class Reporting < ApplicationRecord
  belongs_to :contact
  has_many :reporting_attachments
  accepts_nested_attributes_for :reporting_attachments
end
