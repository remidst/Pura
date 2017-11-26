class Reporting < ApplicationRecord
  belongs_to :contact
  has_many :reporting_attachments
  accepts_nested_attributes_for :reporting_attachments

  after_create :send_reporting_email

  def set_publisher!(user)
  	self.publisher_id = user.id
  	self.save!
  end

  private

  def send_reporting_email
  	ReportingMailer.received_reporting(self).deliver_later
  end


end
