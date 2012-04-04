Auth.controllers :admin do
  
  # Singin an user
  # Create a new UserToken on token cache and return the token id
  post :index do
    username = params[:username]
    password = params[:password]
    if result = Credential.verify(username, password)
      account = result.admin_account
      token = account.signin
      @data = {
        :token => token._id,
        :admin_id => account._id,
        :display_name => account.display_name
      }
      render 'admin/success_signin'
    else
      @error_code = ADMIN_FAILED_SIGNIN
      @error_message = "Invalid username/password"
      render 'error'
    end
  end
  
  # Signout an user
  # Delete the UserToken from token cache
  delete :index, :protect => :require_admin do
    current_token.delete
    render 'admin/signout'
  end

end
