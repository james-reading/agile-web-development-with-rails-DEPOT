require 'test_helper'

class NotifierMailerTest < ActionMailer::TestCase
  test "error_occured" do
    mail = NotifierMailer.error_occured(ActiveRecord::RecordNotFound.new)
    assert_equal "Error occured in depot app", mail.subject
    assert_equal ["jamesreading473@gmail.com"], mail.to
    assert_equal ["depot@example.com"], mail.from
    assert_match(/Hello Admin,/, mail.body.encoded)
  end

end
