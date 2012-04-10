load_config('database.yml').tap do |config|
  SEC_DB = config['eid_security']
  DATA_DB = config['eid_data']
end

DATADB_CONNECTION = Mongo::Connection.new(DATA_DB['host'], DATA_DB['port'])
DATADB_NAME = DATA_DB['database']

SECDB_CONNECTION = Mongo::Connection.new(SEC_DB['host'], SEC_DB['port'])
SECDB_NAME = SEC_DB['database']

MongoMapper.connection = DATADB_CONNECTION
MongoMapper.database = DATADB_NAME