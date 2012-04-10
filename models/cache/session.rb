class Session < ActiveModelBase
  
  attribute :_id, :account_id, :type, :display_name, :expired_at
  attr_accessible :account_id, :type, :display_name
  
  class << self
    def get(sid)
      MEMCACHE.get sid
    end
  end
  
  def initialize(*args)
    super(*args)
    self._id = sha1_digest "#{SecureRandom.uuid}_#{Time.now}"
  end
  
  def store(expiry = SESSION_TIMEOUT)
    self.expired_at = Time.now + expiry.seconds if expiry > 0
    MEMCACHE.set self._id, self, expiry
  end
  
  def delete
    MEMCACHE.delete self._id
  end
  
end