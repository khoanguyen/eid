def sha1_digest(str, salt = '')
  Digest::SHA1.hexdigest("#{str}_#{salt}")
end

def protect_from_anonymous(protect_from)
  condition do
    halt 403 unless params[:token]
  end if protect_from == :anonymous
end

def r(target)
  case content_type
  when :json # JSON
    target.to_json
  else  # Everything else, just return the target itself
    target
  end
end