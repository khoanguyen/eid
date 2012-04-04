FactoryGirl.define do
  factory :user_token do
    _id { UserToken.generate_token_id }
  end
  
  factory :admin_token, :parent => :user_token do
    type Credential::SA_ACCOUNT
    expired_on { Time.now + TOKEN_TIMEOUT }
  end 
end