#
# Author:: Mike Babineau <michael.babineau@gmail.com>
# Cookbook Name:: loggly
# Recipe:: default
#
# Copyright 2011, Electronic Arts, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

package "python-setuptools"
easy_install_package "loggly" do
  version node[:loggly][:loggly_python][:version]
end

file "/etc/profile.d/loggly-env.sh" do
  content <<-EOH
export LOGGLY_USERNAME="#{node[:loggly][:username]}"
export LOGGLY_PASSWORD="#{node[:loggly][:password]}"
export LOGGLY_DOMAIN="#{node[:loggly][:domain]}"
  EOH
end
