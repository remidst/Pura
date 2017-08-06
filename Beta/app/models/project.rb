class Project < ApplicationRecord
	has_many :messages
	has_many :documents
end
