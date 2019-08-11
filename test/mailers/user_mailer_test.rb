require 'test_helper'

class UserMailerTest < ActionMailer::TestCase

  test 'should create password reset email' do
    user = users(:user)
    user.password_reset_token = User.token

    mail = UserMailer.password_reset(user)
    assert_equal 'Password reset', mail.subject
    assert_equal [user.email], mail.to
    assert_equal ['from@example.com'], mail.from
    assert_match user.password_reset_token, mail.body.encoded
    assert_match CGI.escape(user.email), mail.body.encoded
  end

end