def r(result, opt = {})
  opt.merge(:ok => true, :result => result).to_json
end

def r_ok(opt = {})
  opt.merge(:ok => true).to_json
end

def fail(code, message, opt = {})
  opt.merge(:ok => false, :error_code => code, :error_message => message).to_json
end

def current_session
  Session.get request.env['HTTP_TOKEN']
end

def validate_session(expected_type = Credential::USER_ACCOUNT)
  if request.env['HTTP_TOKEN'].present?
    session = current_session
    if session && session.type == expected_type
      session.store 
      return true
    end
  end
  false 
end

def current_user
  session = current_session
  case session.type
  when Credential::SA_ACCOUNT
    Admin.find(session.account_id)
  when Credential::USER_ACCOUNT
    nil
  else 
    nil
  end
end