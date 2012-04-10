#!/usr/bin/env ruby

sub_fix = ARGV[0] == 'test' ? '_test' : '_dev'

app_config = %q{
session_timeout: 600
}

database_config = %Q{
eid_security:
  host: localhost
  port: 27017
  database: eid_security#{sub_fix}

eid_data:
  host: localhost
  port: 27017
  database: eid_data#{sub_fix}
}

memcached_config = %q{
memcachedA:
  host: localhost
  port: 11211
}

Dir.mkdir "config/#{ARGV[0]}" unless Dir.exist? "config/#{ARGV[0]}"

File.open("config/#{ARGV[0]}/app.yml", 'w') { |f| f.write(app_config) }
File.open("config/#{ARGV[0]}/database.yml", 'w') { |f| f.write(database_config) }
File.open("config/#{ARGV[0]}/memcached.yml", 'w') { |f| f.write(memcached_config) }