require 'json-parser'
require 'json'
require 'date'
require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

config_location = '/home/user/modules/config_mgt/files/config_data.json'

file = File.read(config_location)

data_hash = JSON.parse(file)

restart = "service apache2 restart"

#scheduler.every '10s' do

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
	 system "#{restart}" #restart the apache2 instance
	end #end of else for php creation and apache2 restart
   end #end top if
end #end of hash
#end #end of scheduler
