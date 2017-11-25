class Contact < ApplicationRecord
  belongs_to :care_manager, class_name: "User"
  belongs_to :service_provider, class_name: "User"
  has_many :reportings
end
