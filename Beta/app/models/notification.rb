class Notification < ApplicationRecord
  belongs_to :project
  belongs_to :user

  def new_document!
  	self.content = "新しいファイルが共有されました。"
  	self.save!
  end

  def new_message!
  	self.content = "新しいメッセージが共有されました。"
  	self.save!
  end

  def new_project!
  	self.content = "新しい案件に招待されました。"
  	self.save!
  end

  def new_user!
  	self.content = "新しいメンバーが案件に招待されました。"
  	self.save!
  end

  def new_leader!
  	self.content = "担当ケアマネジャーのアクセス権限が与えられました。"
  	self.save!
  end

  def read!
    self.read = true
    self.save!
  end

end
