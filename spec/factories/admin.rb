FactoryGirl.define do
  factory :admin do
    _id { SecureRandom.uuid }
  end
end