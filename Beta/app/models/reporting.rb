class Reporting < ApplicationRecord
  belongs_to :contact
  belongs_to :publisher, class_name: "User"
  has_many :reporting_attachments, dependent: :destroy
  accepts_nested_attributes_for :reporting_attachments

  def set_publisher!(user)
  	self.publisher_id = user.id
  	self.save!
  end


end
