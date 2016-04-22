magento
==========

Magento environment with Berkshelf Chef and Vagrant support

Php7 support via ppa:ondrej/php.

Requirements
------------
* chef-dk
* chef-solo
* berkshelf

Extra development requirements
-----------------------------
* vagrant
* virtualbox

Resources links
---------------
* Chef DK(includes Berkshelf): https://downloads.getchef.com/chef-dk/
* Vagrant: https://www.vagrantup.com/downloads.html
* Virtualbox: https://www.virtualbox.org/wiki/Downloads


How to test dev environment
---------------------------
- Clone the repository
- Go to the project root
- Run "kitchen converge default-ubuntu-1404"

Customizing your dev environment
--------------------------------
The role used to provision the dev environment, you can create your own role to fit your needs:
```json
{
    "name": "magento",
    "chef_type": "role",
    "json_class": "Chef::Role",
    "description": "Magento environment configuration.",
    "run_list": [
        "recipe[magento]",
        "recipe[magento::test]",
        "recipe[lamp::nfs]",
        "recipe[lamp::xdebug]"
    ],
    "default_attributes": {
        "lamp": {
            "xdebug": {
                "directives": {
                    "remote_host": "10.0.2.2",
                    "remote_enable": 0,
                    "remote_autostart": 1
                }
            }
        },
        "php": {
            "packages": [
                "php5-mcrypt",
                "php5-curl"
            ]
        }
    }
}
```