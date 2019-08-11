require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:user)
    @user_with_token = users(:user_with_token)
  end

  test 'should access password reset form' do
    get new_password_reset_path
    assert_response :success
  end

  test 'should fail due to invalid email' do
    post password_resets_path, params: {password_reset: {email: ''}}
    assert_not flash.empty?
    assert_response :redirect
  end

  test 'should send reset password email' do
    post password_resets_path, params: {password_reset: {email: @user.email}}
    assert_not_equal @user.password_reset_digest, @user.reload.password_reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test 'should fail due to invalid token' do
    get edit_password_reset_path('invalid token', email: @user_with_token.email)
    assert_redirected_to root_url
  end

  test 'should render password reset form' do
    get edit_password_reset_path('token', email: @user_with_token.email)
    assert_response :success
    assert_select 'input[name=email][type=hidden][value=?]', @user_with_token.email
  end

  test 'should fail due to invalid password confirmation' do
    patch password_reset_path('token'),
          params: {
              email: @user_with_token.email,
              user: {
                  password: 'password',
                  password_confirmation: 'confirmation'
              }
          }
    assert_select 'div.alert-danger'
  end

  test 'should fail due to empty password' do
    patch password_reset_path('token'),
          params: {
              email: @user_with_token.email,
              user: {
                  password: '',
                  password_confirmation: ''
              }
          }
    assert_select 'div.alert-danger'
  end

  test 'should successfully reset password' do
    patch password_reset_path('token'),
          params: {
              email: @user_with_token.email,
              user: {
                  password: 'password',
                  password_confirmation: 'password'
              }
          }
    assert_redirected_to edit_user_path(@user_with_token)
    follow_redirect!
    assert_select 'div.alert-success'
  end

  test 'should fail due to expired token' do
    @user_with_token.password_reset_sent_at = 8.hours.ago
    @user_with_token.save

    patch password_reset_path('token'),
          params: {
              email: @user_with_token.email,
              user: {
                  password: 'password',
                  password_confirmation: 'password'
              }
          }
    assert_response :redirect
    follow_redirect!
    assert_select 'div.alert-danger'
  end
end