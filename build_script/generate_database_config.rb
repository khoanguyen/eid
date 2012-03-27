#!/usr/bin/env ruby

config = %q{
require 'mongo_mapper'
require 'mongo'

case PADRINO_ENV
when "test"
  SEC_DB = {
    :host => "localhost",
    :port => 27017,
    :database => "eid_security_test" 
  }
  DATA_DB = {
    :host => "localhost",
    :port => 27017,
    :database => "eid_data_test" 
  }
when "production"
  SEC_DB = {
    :host => "localhost",
    :port => 27017,
    :database => "eid_security_dev" 
  }
  DATA_DB = {
    :host => "localhost",
    :port => 27017,
    :database => "eid_data_dev" 
  }
end

DATADB_CONNECTION = Mongo::Connection.new(DATA_DB[:host], DATA_DB[:port])
DATADB_NAME = DATA_DB[:database]

SECDB_CONNECTION = Mongo::Connection.new(SEC_DB[:host], SEC_DB[:port])
SECDB_NAME = SEC_DB[:database]

MongoMapper.connection = DATADB_CONNECTION
MongoMapper.database = DATADB_NAME
}

File.open(ARGV[0], 'w') { |f| f.write(config) }