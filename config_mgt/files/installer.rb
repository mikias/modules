require 'json-parser'
require 'json'
require 'date'

config_location = '/home/user/modules/config_mgt/files/config_data.json'

file = File.read(config_location)

data_hash = JSON.parse(file)

restart = "service apache2 restart"

data_hash.each do |key,value|# hash...

	if(value['type'].eql?('package') && value['version'].nil?)
	  system( "dpkg -l | grep -q #{key}" ) #quiet grep
	  if($?.exitstatus > 0)
	  	system "sudo apt-get install -y #{key} > /dev/null"
	  end #end of exitstatus
	  system ""#reset exitcode
         end #end  #php,apache install
	if(value['type'].eql?('service'))
		system("#{value['type']} #{value['name']} status > /dev/null")
		if($?.exitstatus > 0)
			system "#{value['type']} #{value['name']} #{key} > /dev/null"
    end #end of exitstatus
  system "#{value['type']} #{value['name']} start" #if not clean uninstall
    if($?.exitstatus > 0)
      system "sudo #{value['type']} #{value['name']} stop"
      system "sudo apt-get remove --purge $APACHE_PKGS"
      system "apt-get purge #{value['name']} -y"
      system "sudo apt-get install -y #{value['name']} > /dev/null"
    end
    system ""#reset exitcode
	end #end #start the necessary services
	if(value['type'].eql?('file'))
		path_name = "#{value['path']}"
		File.file?(path_name)
		dir_name = File.dirname(path_name)
		Dir.chdir(dir_name)
		if(File.file?(path_name))
	    read_file = File.read(path_name) #file is read
	else
	   system "touch #{key} > /dev/null" #create the php by force
	   read_file = File.read(path_name) #file is read
	end
	if(read_file != ('<?php header("Content-Type: text/plain"); echo "Hello, world!\n";?>'))
        #end #end of file comparision
	  system "touch #{key} > /dev/null" #create the php by force
	  File.open("#{key}", "w") { |file| #write to the php file the orignal content
	  	file.write('<?php header("Content-Type: text/plain"); echo "Hello, world!\n";?>')
	  }
	 system "#{restart} > /dev/null" #restart the apache2 instance
	end #end of else for php creation and apache2 restart
   end #end top if
end #end of hash
