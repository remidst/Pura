class Reporting < ApplicationRecord
  belongs_to :contact
  has_many :reporting_attachments
  accepts_nested_attributes_for :reporting_attachments

  def set_publisher!(user)
  	self.publisher_id = user.id
  	self.save!
  end


end
