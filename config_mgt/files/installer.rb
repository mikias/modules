require 'json-parser'
require 'json'
require 'date'

config_location = '/home/miki/modules/config_mgt/files/config_data.json'

file = File.read(config_location)

data_hash = JSON.parse(file)

data_hash.each do |key,value|# hash...

	if(value['type'].eql?('package') && !value['version'].nil?)
          system "gem install #{value['package']} > /dev/null"
          #gem install json
	end
	if(value['type'].eql?('package') && value['version'].nil?)
          system "sudo apt-get install -y #{key} > /dev/null"
          #php,apache install     
        end
    	if(value['type'].eql?('service'))
	  system "#{value['type']} #{value['name']} #{key} > /dev/null"
	  #start the necessary services
	end
        if(value['type'].eql?('services'))
          if(File.file?('/usr/bin/php') && File.file?('/usr/sbin/apache2') && 
	  ((Date.today - File.mtime('/usr/bin/php').to_date).to_i < 1 || 
	  (Date.today - File.mtime('/usr/sbin/apache2').to_date).to_i < 1))
	  system "#{value['type']} #{value['name']} #{value['mod_operation']} > /dev/null"
	  #restarts the apache instance
	end
    end	
	if(value['type'].eql?('file'))
	  dir_path = "#{value['path']}"
	  dir_name = File.dirname(dir_path)
	  Dir.chdir(dir_name)
	  system "touch #{key} > /dev/null"
	  #generate sample php file
	  File.open("#{key}", "w+") { |file| file.write('<?php
    header("Content-Type: text/plain");
    echo "Hello, world!\n";
?>') }

	end 
   end

