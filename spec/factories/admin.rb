FactoryGirl.define do
  factory :admin do
    _id { UUID::generate }
  end
end