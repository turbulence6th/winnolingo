ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  fixtures :all

  def login(email, password)
    old_controller = @controller
    @controller = UsersController.new 

    post(:login, { :email => email, :password => password, :session => {
      :device_type => "browser", :device_id => SecureRandom.uuid, :push_token => SecureRandom.uuid }})

    @controller = old_controller
  end
end
