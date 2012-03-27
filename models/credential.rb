class Credential
  
  SA_ACCOUNT = 'sa'
  USER_ACCOUNT = 'user'
  
  include MongoMapper::Document
  connection SECDB_CONNECTION
  set_database_name SECDB_NAME
  set_collection_name :credential
  
  key :user_name, String
  key :password, String
  key :salt, String
  key :accounts, Array 
  timestamps!
  
  def self.verify(username, password)
    result = Credential.first(:user_name => username)
    return nil unless result
    password = sha1_digest(password, result.salt) if result.salt
    return nil unless password == result.password
    result
  end
  
  def user_account
    # assoc_account = first_account(USER_ACCOUNT)
    #     user_account = Admin.find(assoc_account["account_id"])
    #     user_account.display_name ||= self.user_name
    #     user_account
  end
  
  def admin_account
    assoc_account = first_account(SA_ACCOUNT)
    return nil unless assoc_account
    admin_account = Admin.find(assoc_account["account_id"])
    admin_account.display_name ||= self.user_name
    admin_account
  end
  
  private 
  
  def first_account(type)
    self.accounts.select { |i| i["account_type"] == SA_ACCOUNT }[0]
  end
end