class UserToken
  include MongoMapper::Document
  connection SECDB_CONNECTION
  set_database_name SECDB_NAME
  set_collection_name :user_token
  
  key :account_id, String
  key :type, String
  # key :expired_on, Time
  
  def self.create_admin_token(admin)
    self.clean_expired_token(admin._id)
    result = UserToken.new(:type => Credential::SA_ACCOUNT, :account_id => admin._id)
    result._id = UserToken.generate_token_id                                                                                                                                                             
    result['expired_on'] = Time.now + TOKEN_TIMEOUT
    result.save!
    result
  end
  
  def self.generate_token_id
    SecureRandom.uuid
  end
  
  def update_token
    self['expired_on'] = Time.now + TOKEN_TIMEOUT unless expired?
    self.save!
  end
  
  def expired?
    return true unless self.attributes.has_key? :expired_on
    if self.expired_on.instance_of?(Time)
      Time.now > self.expired_on
    else
      true
    end
  end
  
  private
   
  def self.clean_expired_token(account_id)
    tokens = UserToken.all(:account_id => account_id)
    tokens.each { |t| t.delete if t.expired? }
  end
end