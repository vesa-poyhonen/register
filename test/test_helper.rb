ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  # Returns true if a user is logged in
  def is_logged_in?
    !session[:user_id].nil?
  end

  # Login as a user
  def login(user)
    session[:user_id] = user.id
  end
end

class ActionDispatch::IntegrationTest
  # Login as a user
  def login(user, password: 'password')
    post login_path,
         params: {
             session: {
                 email: user.email,
                 password: password
             }
         }
  end
end