Loggly Cookbook
====================
Installs the loggly-python library and provides a definition for the configuration of Loggly logging.

More specifically, the `loggly_conf` definition will configure rsyslog to watch a log file and send its lines to a Loggly input.  When first run, `loggly_conf` will create the input and authorize the server to publish events to that input.

Developed for and tested on Ubuntu 10.10 LTS

Written by [EA2D](http://ea2d.com) and maintained here:
<https://github.com/EA2D/loggly-cookbook>


Requirements
--------------------
* Loggly account
* rsyslog configured and running



Attributes
--------------------
Required:

* `loggly.domain` - Loggly domain (e.g., "mysite.loggly.com")
* `loggly.username` - Loggly username
* `loggly.password` - Loggly password

Optional:

* `loggly.loggly_python.version` - version of the [loggly-python](https://github.com/EA2D/loggly-python) library to install (default is 0.1.2)

JSON example:

    "loggly": {
      "username": "saucier",
      "password": "h0llandaise",
      "domain": "mysite"
    }


Usage
--------------------
Example:

    loggly_conf "nginx-error" do
        device_ip node[:ip_address]
        input_file "/var/log/nginx/error.log"
        input_file_tag "nginx-error"
        input_file_state_file "stat-nginx-error"
    end


Contributing
--------------------
Want to contribute?  Great!  Here's how:

* Fork the GitHub repository (<https://github.com/EA2D/loggly-cookbook>)
* Apply your changes - bonus points for using a topic branch!
* Send a pull request (see <http://help.github.com/pull-requests/>)

We'll review, merge, and publish the changes!  If you have any questions, email <ops@ea2d.com>.


License
--------------------

    Copyright 2011 Electronic Arts Inc.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
