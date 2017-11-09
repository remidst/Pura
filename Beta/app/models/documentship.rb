class Documentship < ApplicationRecord
  belongs_to :document
  belongs_to :user

  validates_uniqueness_of :user_id, scope: :document_id

end
