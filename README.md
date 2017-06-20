<b>Openresty Puppet Module</b> <br>
* This Puppet module is used to configure and install openresty from source with custom or third party modules.

<b>How to run</b><br>

<i>on standalone puppet agent:</i>
* Place the module "openresty" in /etc/puppet/modules folder
* Run command : puppet apply --modulepath=/etc/puppet/modules -e "include openresty" --debug

<i>on Master-agent Arch:</i>
* Use the module on master sever, 
* sync the agent with master
* run puppet agent command on Agent Node Server.

<b>Dependencies</b><br>
* In case of depnendency failure, Update the package manager(yum, apt, etc) used on Agent node server
