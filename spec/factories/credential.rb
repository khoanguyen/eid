FactoryGirl.define do
  factory :credential do
    _id { UUID.generate }
    salt { UUID.generate }
    password { sha1_digest('test', self.salt) }
  end
end