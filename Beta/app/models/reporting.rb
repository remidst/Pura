class Reporting < ApplicationRecord
  belongs_to :contact
  has_many :reporting_attachments
end
