class Reporting < ApplicationRecord
  belongs_to :contact
  belongs_to :publisher, class_name: "User"
  has_many :reporting_attachments, dependent: :destroy
  has_many :reporting_readmarks, dependent: :destroy

  accepts_nested_attributes_for :reporting_attachments

  after_create :create_reporting_readmarks

  def receiver
    contact = self.contact
    self.publisher == contact.care_manager ? receiver = contact.service_provider : receiver = contact.care_manager
    return receiver
  end

  def set_publisher!(user)
  	self.publisher_id = user.id
  	self.save!
  end

  def self.add_confirmed
    reportings = Reporting.all

    reportings.each do |reporting|
      reporting.update!(confirmed: true)
    end
  end

  def self.confirm!
    self.confirmed = true
    self.update!
  end

  private

  def create_reporting_readmarks
  	contact = self.contact

    publisher = self.publisher
    self.publisher == contact.care_manager ? receiver = contact.service_provider : receiver = contact.care_manager

    #one readmark as read for the publisher, another unread for the receiver
  	self.reporting_readmarks.create!(read: true, user_id: publisher.id)
  	self.reporting_readmarks.create!(read: false, user_id: receiver.id)
  end


end
