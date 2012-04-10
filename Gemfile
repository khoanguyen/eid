source :rubygems

# Server requirements (defaults to WEBrick)
# gem 'thin'
# gem 'mongrel'

# Project requirements
gem 'rake'
gem 'sinatra-flash', :require => 'sinatra/flash'

# Component requirements
gem 'mongo_mapper'
gem 'bson_ext'
gem 'activemodel', :require => 'active_model'
gem 'memcache-client', :require => 'memcache'

# Test requirements
gem 'rspec', :group => "test"
gem 'factory_girl', :group => "test"
gem 'rack-test', :require => "rack/test", :group => "test"

# Padrino Stable Gem
gem 'padrino'

# Or Padrino Edge
# gem 'padrino', :git => 'git://github.com/padrino/padrino-framework.git'

# Or Individual Gems
# %w(core gen helpers cache mailer admin).each do |g|
#   gem 'padrino-' + g, '0.10.5'
# end

group :development do
  gem 'shotgun'
end