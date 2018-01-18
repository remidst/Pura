class PublicationReadmark < ApplicationRecord
  belongs_to :publication
  belongs_to :user

  def self.publication_read!
  	self.update(read: true)
  end
end
