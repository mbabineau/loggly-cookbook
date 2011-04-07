define :loggly_conf, :action => :create do
  
  include_recipe "loggly"
  service "rsyslog"
  
  input_name = params[:name]
  
  # So we don't hammer Loggly's API
  bash "remote loggly configuration" do
    not_if "test -f /var/lock/loggly-#{input_name}"
    code <<-EOH
      loggly-create-input -U #{node[:loggly][:username]} -P #{node[:loggly][:password]} -D #{node[:loggly][:domain]} -i #{input_name} -s syslogtcp
      loggly-add-device -U #{node[:loggly][:username]} -P #{node[:loggly][:password]} -D #{node[:loggly][:domain]} -i #{input_name} -d #{params[:device_ip]}
      touch /var/lock/loggly-#{input_name}
    EOH
  end
  
  directory "/var/cache/loggly"
  
  # So we don't hammer Loggly's API
  input_port = `cat /var/cache/loggly/#{input_name}.port`
  if input_port == ""
    input_port = `loggly-describe-input -U #{node[:loggly][:username]} -P #{node[:loggly][:password]} -D #{node[:loggly][:domain]} -i #{input_name} -a port`.strip
    file "/var/cache/loggly/#{input_name}.port" do
      content input_port
    end
  end
    
  file "/etc/rc6.d/remove-from-loggly-#{input_name}" do
    content <<-EOH
#!/bin/bash -l
loggly-remove-device -i #{input_name} -d #{params[:device_ip]}
    EOH
  end
  
  template "/etc/rsyslog.d/10-loggly-#{input_name}.conf" do
    source "loggly_conf.erb"
    cookbook "loggly"
    variables(
      :input_port => input_port,
      :params => params
    )
    notifies :restart, resources(:service => "rsyslog"), :delayed
  end

end
