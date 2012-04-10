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
        body['error_code'].should == AUTHENTICATION_ERROR
        body['error_message'].should == "Invalid username/password"
  end
  
  it 'should return success login with valid credential' do
    post '/auth/admin', {:username => "admin", :password => "test"}
    last_response.status.should be(200)
    body = JSON.parse(last_response.body)
    body['ok'].should == true
    data = body['result']
    data['type'].should == Credential::SA_ACCOUNT
    data['account_id'].should == self.admin._id
    data['display_name'].should == 'admin'
    
    session = Session.get(data['token'])
    session.should_not be_nil
    session.account_id.should == self.admin._id
    session.type.should == Credential::SA_ACCOUNT
    session.display_name.should == 'admin'
    
    # Signout
    delete '/auth/admin', {}, { 'HTTP_TOKEN' => session._id }
  end
    
    it 'should say "Access Denied " when user access signout service without valid user-token' do
      post '/auth/admin', {:username => "admin", :password => "test"}
      delete '/auth/admin'
      last_response.status.should be(403)
    end
    
    it 'should sign the user out with a valid user-token' do
      post '/auth/admin', {:username => "admin", :password => "test"}
      token = JSON::parse(last_response.body)['result']['token'] 
      delete '/auth/admin', {} , { 'HTTP_TOKEN' => token }
      last_response.status.should be(200)
      body = JSON.parse(last_response.body)
      body['ok'].should == true
    end 
  
end
