class Project < ApplicationRecord
	has_many :memberships, dependent: :destroy
	has_many :users, through: :memberships
	attr_reader :user_tokens

	has_one :leader, class_name: 'User', foreign_key: 'leader_id'
	has_many :conversations, dependent: :destroy
	has_many :documents, dependent: :destroy
	has_many :notifications, dependent: :destroy
	has_one :spec, dependent: :destroy

  after_create :create_spec

  def leader
    self.memberships.where(type: 'leader').first
  end

  def user_tokens=(ids)
  	self.user_ids = ids.split(",")
  end

  def self.specs_adder_temp
  	@projects = Project.all
  	@projects.each do |project|
  		if project.leader_id.present?
	  		spec = Spec.create(project_id: project.id, publisher_id: project.leader_id)
	  	end
  	end
  end

  private

  def create_spec
    spec = Spec.create(project_id: self.id,publisher_id: self.leader_id)
  end
  
end
