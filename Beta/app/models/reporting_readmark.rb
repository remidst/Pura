class ReportingReadmark < ApplicationRecord
  belongs_to :user
  belongs_to :reporting


  def self.reporting_read!
  	self.update(read: true)
  end

end