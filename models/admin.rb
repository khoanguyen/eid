class Admin
  include MongoMapper::Document
  connection SECDB_CONNECTION
  set_database_name SECDB_NAME
  set_collection_name :sa_account
  
  key :display_name, String
  key :account_type, String
  
  def signin
    session = Session.new(:account_id   => self._id, 
                          :type         => Credential::SA_ACCOUNT, 
                          :display_name => self.display_name)
    session.store
    session
  end
  
end