class Notification < ApplicationRecord
  belongs_to :project
  belongs_to :user

  def new_document!
  	self.content = "新しいファイルが共有されました。"
  	self.save!
  end
end
