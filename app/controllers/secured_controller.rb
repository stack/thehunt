class SecuredController < ApplicationController
  http_basic_authenticate_with :name => 'admin', :password => 'password'
end
