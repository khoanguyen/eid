# Global protectors
module Padrino
  class Application
    class << self
      def protect(*args)
        condition do
          puts "Require admin"
          self.require_admin
        end if args.include?(:require_admin)
      
        condition do
          puts "Require user"
          self.require_user
        end if args.include?(:require_user)
      
        condition do
          puts "Require login"
          self.require_login
        end if args.include?(:require_login)
      end
    end
  
    def require_user
      halt 403, 'Access Denied' unless validate_session(Credential::USER_ACCOUNT)
    end
  
    def require_admin
      halt 403, 'Access Denied' unless validate_session(Credential::SA_ACCOUNT)
    end
  
    def require_login
      halt 403, 'Access Denied' unless validate_session(Credential::ANY_ACCOUNT)
    end
  end
end