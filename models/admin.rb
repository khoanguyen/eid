class Admin
  include MongoMapper::Document
  connection SECDB_CONNECTION
  set_database_name SECDB_NAME
  set_collection_name :sa_account
  
  key :display_name, String
  key :account_type, String
  
  def signin
    old_tokens = UserToken.all :account_id => self._id
    old_tokens.each { |token| token.delete if token.expired? }
    UserToken.create_admin_token(self)
  end
  
end