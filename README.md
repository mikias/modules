# server configuration manager
## Synopsis

Simple configuration management system for apache and php on ubuntu

## Code Example
`bash uninstaller.sh` <br />
`bash bootstrap.sh` <br />
`ruby installer.rb`
## Installation
move files to `/home/${user}/modules/config_mgt/files/` <br />
use bash uninstaller.sh to uninstall `apache,php,ruby` and other installed gems (not required) <br />
use bash bootstrap.sh to install all necessary dependencies for the linux box's automation <br />
use `ruby installer.rb` to start and configure `apache` and `php`. <br />
create a crontab with `crontab -e` to configure tasks every `x` minutes (idempotent) with <br />
`*/5 * * * * ruby /home/user/modules/config_mgt/files/installer.rb` for automated result
<br />
## API Reference
config_data.json used for the required metadata

## Tests
`installer.rb` will be triggered by crontab or manually by `ruby installer.rb`  <br />
check `/var/www/html/yukon_cornelilous.php` to check if apache and php respond with 200 OK and include the string "`Hello, world!`" in response to requests from `curl -sv "http://ADDRESS"` <br />
to confirm the script is running do `tail -f /var/log/syslog`

## Contributors
## License
None
