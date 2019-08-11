require 'test_helper'

class UserLoginsTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:user)
  end

  test 'should fail due to invalid credentials' do
    get login_path
    post login_path,
         params: {
             session: {
                 email: '',
                 password: ''
             }
         }
    assert_response :success
    assert_select 'div.alert-danger'
  end

  test 'should login and logout user with valid credentials' do
    get login_path
    post login_path,
         params: {
             session: {
                 email: @user.email,
                 password: 'password'
             }
         }
    assert_redirected_to edit_user_path(@user)
    follow_redirect!
    assert_response :success
    assert is_logged_in?

    # Logout user
    get logout_path
    assert_redirected_to root_url
    follow_redirect!
    assert_response :success
    assert_not is_logged_in?
  end

end