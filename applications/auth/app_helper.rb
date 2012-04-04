module AppHelper
  def current_token
    UserToken.find request['HTTP_TOKEN']
  end
  
  def validate_token(expected_type = Credential::USER_ACCOUNT)
    if request['HTTP_TOKEN'].present?
      token = current_token
      if token && !token.expired? && token.type == expected_type
        token.update_token 
        return true
      end
    end
    false
  end
  
  def current_user
    token = current_token
    case token.type
    when Credential::SA_ACCOUNT
      Admin.find(token.account_id)
    when Credential::USER_ACCOUNT
      nil
    else 
      nil
    end
  end
  
end