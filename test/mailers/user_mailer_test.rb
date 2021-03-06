require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
    test "account_activation" do
        user = users(:Porl)
        user.activation_token = User.new_token
        mail = UserMailer.account_activation(user)
        assert_equal "Account activation", mail.subject
        assert_equal [user.email], mail.to
        assert_equal ['kouta11kk.171@gmail.com'], mail.from
        assert_match CGI.escape(user.email),  mail.html_part.body.decoded
        assert_match user.name,               mail.html_part.body.decoded
        assert_match user.activation_token,   mail.html_part.body.decoded
    end
end
