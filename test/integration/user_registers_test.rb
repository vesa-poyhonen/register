require 'test_helper'

class UserRegistersTest < ActionDispatch::IntegrationTest

  test "should fail due to invalid register information" do
    get register_path
    assert_no_difference 'User.count' do
      post users_path, params: {
          user: {
              email: "somebody@invalid",
              password: "password1",
              password_confirmation: "password2"
          }
      }
    end
    assert_response :success
    assert_select 'div.alert-danger'
  end

  test "should be valid registration" do
    get register_path
    assert_difference 'User.count', 1 do
      post users_path, params: {
          user: {
              email: "new.user@example.com",
              password: "password",
              password_confirmation: "password"
          }
      }
    end
    follow_redirect!
    assert_response :success
    assert_select 'div.alert-success'
  end
end