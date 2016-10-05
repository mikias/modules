# modules
## Synopsis

Simple configuration management system for apache and php on ubuntu

## Code Example
bash uninstaller.sh <br />
bash bootstrap.sh <br />
ruby installer.rb
## Installation
move files to `/home/${whoami}/modules/config_mgt/files/` <br />
use bash uninstaller.sh to uninstall apache,php,ruby and other installed gems <br />
use bash bootstrap.sh to install all necessary dependencies for the linux box <br />
use ruby installer.rb to start and configure apache and php. <br />
## API Reference
simple json api, config_data.json for the required metadata

## Tests
ruby installer.rb <br />
check /var/www/html/yukon_cornelilous.php to check if apache and php respond with 200 OK and include the string "Hello, world!" in response to requests from `curl -sv "http://ADDRESS"`

## Contributors
http://www.github.com/mikias
## License
None
