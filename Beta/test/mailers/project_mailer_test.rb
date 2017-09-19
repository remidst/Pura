require 'test_helper'

class ProjectMailerTest < ActionMailer::TestCase
  test "create_project" do
    mail = ProjectMailer.create_project
    assert_equal "New project", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
