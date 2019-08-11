require 'test_helper'

class UserEditsTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:user)
    @another_user = users(:user_with_token)
  end

  test "should not edit user successfully" do
    login(@user)
    get edit_user_path(@user)
    assert_response :success

    patch user_path(@user),
          params: {
              user: {
                  username: "",
                  email: "somebody@invalid",
                  password: "password",
                  password_confirmation: "confirmation"
              }
          }

    assert_response :success
    assert_select 'div.alert-danger'

    @user.reload
    assert_not_equal "", @user.username
    assert_not_equal "somebody@invalid", @user.email
  end

  test "should edit user successfully" do
    login(@user)
    get edit_user_path(@user)
    assert_response :success

    patch user_path(@user),
          params: {
              user: {
                  username: "New Username",
                  email: "new.email@example.com",
                  password: "",
                  password_confirmation: ""
              }
          }

    assert_response :redirect
    follow_redirect!
    assert_select 'div.alert-success'

    @user.reload
    assert_equal "New Username", @user.username
    assert_equal "new.email@example.com", @user.email
  end

  test "should not be able to edit another user" do
    login(@user)
    get edit_user_path(@another_user)
    assert_redirected_to edit_user_path(@user)

    patch user_path(@another_user),
          params: {
              user: {
                  username: @another_user.username,
                  email: @another_user.email
              }
          }

    assert_redirected_to edit_user_path(@user)
  end

  test "should redirect to login when not logged in" do
    get edit_user_path(@user)
    assert_redirected_to login_url

    patch user_path(@user),
          params: {
              user: {
                  username: @user.username,
                  email: @user.email
              }
          }

    assert_redirected_to login_url
  end

end