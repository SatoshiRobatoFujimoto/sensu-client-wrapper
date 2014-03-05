#
# Cookbook Name:: sensu-client-wrapper
# Recipe:: auto-remove 
#
# Copyright 2013, Ryutaro YOSHIBA 
#
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

node_name = node_name() # from helper

if platform_family?("rhel")
  template "/etc/rc.d/init.d/sensu-client-remove" do
    source "sensu-client-remove.erb"
    mode 0755
    owner "root"
    group "root"
    variables({
      :node_name => node_name
    })
  end

  execute "/sbin/chkconfig --level 0 sensu-client-remove off" do
    action :run
  end
  
  execute "/sbin/chkconfig --level 2345 sensu-client-remove on" do
    action :run
  end
  
  execute "/etc/rc.d/init.d/sensu-client-remove start" do
    action :run
  end
end
