Auth.controllers :admin do
  
  # Singin an user
  # Create a new UserToken on token cache and return the token id
  post :index do
    begin
      auth_info = AuthInfo.new params
      if credential = Credential.verify(auth_info.username, auth_info.password)
        account = credential.admin_account
        session = account.signin
        result = {
          :token => session._id,
          :account_id => account._id,
          :type => Credential::SA_ACCOUNT,
          :display_name => account.display_name
        }
        r result
      else
        fail AUTHENTICATION_ERROR, "Invalid username/password"
      end
    rescue Exception => e
      fail UNKNOWN_ERROR, e.message
      puts e.backtrace if Padrino.env != :production
    end
  end
  
  # Signout an user
  # Delete the UserToken from token cache
  delete :index, :protect => :require_admin do
    current_session.delete
    r_ok
  end

end
