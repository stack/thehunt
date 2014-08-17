class SecuredController < ApplicationController
  http_basic_authenticate_with :name => APP_CONFIG['username'], :password => APP_CONFIG['password']
end
