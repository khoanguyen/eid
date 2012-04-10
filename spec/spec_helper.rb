RACK_ENV = 'test'
PADRINO_ENV = 'test'
 # unless defined?(PADRINO_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include FactoryGirl::Syntax::Methods
  
  config.after(:each) do
    Admin.delete_all
    Credential.delete_all
  end
end

def app
  ##
  # You can handle all padrino applications using instead:
  #   Padrino.application
  # Eid.tap { |app|  }
  Padrino.application
  # Rabl.register! 
end

FactoryGirl.definition_file_paths = [
    File.join(Padrino.root, 'factories'),
    File.join(Padrino.root, 'test', 'factories'),
    File.join(Padrino.root, 'spec', 'factories')
]
FactoryGirl.find_definitions
