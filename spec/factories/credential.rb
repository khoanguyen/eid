FactoryGirl.define do
  factory :credential do
    _id { SecureRandom.uuid }
    salt { SecureRandom.uuid }
    password { sha1_digest('test', self.salt) }
  end
end