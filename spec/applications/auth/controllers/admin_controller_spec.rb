require 'spec_helper'

describe "AdminController" do
  
  let!(:admin) { create :admin }
  let!(:credential) do
    create :credential,
      :user_name => "admin",
      :accounts => [
          {
            :account_type => Credential::SA_ACCOUNT,
            :account_id => self.admin._id 
          }
        ] 
  end
  
  it 'should return fail login with invalid credential' do
    post '/auth/admin', {:username => "smith", :password => "test"}
    last_response.status.should be(200)
        body = JSON.parse(last_response.body)
        body['ok'].should == false
        body['error_code'].should be(ADMIN_FAILED_SIGNIN)
        body['error_message'].should == "Invalid username/password"
  end
  
  it 'should return success login with valid credential' do
    post '/auth/admin', {:username => "admin", :password => "test"}
    last_response.status.should be(200)
    body = JSON.parse(last_response.body)
    body['ok'].should == true
    data = body['data']
    data['admin_id'].should == self.admin._id
    data['display_name'].should == 'admin'
    token = UserToken.find(data['token'])
    token.account_id.should == self.admin._id
    token.type.should == Credential::SA_ACCOUNT
    (Time.now < token.expired_on).should be_true
  end
    # 
    # it 'should say "Access Denied " when user access signout service without valid user-token' do
    #   delete '/auth/admin'
    #   last_response.status.should be(403)
    # end
    # 
    # it 'should sign the user out with a valid user-token'  
  
end
