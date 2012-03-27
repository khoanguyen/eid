Auth.controllers :admin do
  
  ## Login
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
  
  delete :index do
    token = request.env['HTTP_TOKEN']
    halt 403 unless token 
  end

end
