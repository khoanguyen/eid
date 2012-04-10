#!/usr/bin/env ruby

app_config = %q{
session_timeout: 600
}

database_config = %q{
eid_security:
  host: localhost
  port: 27017
  database: eid_security_dev

eid_data:
  host: localhost
  port: 27017
  database: eid_data_dev
}

memcached_config = %q{
memcachedA:
  host: localhost
  port: 11211
}

File.open("config/#{ARGV[0]}/app.yml", 'w') { |f| f.write(app_config) }
File.open("config/#{ARGV[0]}/database.yml", 'w') { |f| f.write(database_config) }
File.open("config/#{ARGV[0]}/memcached.yml", 'w') { |f| f.write(memcached_config) }