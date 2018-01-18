class Project < ApplicationRecord
	has_many :memberships, dependent: :destroy
	has_many :users, through: :memberships
	attr_reader :user_tokens

	has_one :leader, class_name: 'User', foreign_key: 'leader_id'
	has_many :conversations, dependent: :destroy
	has_many :documents, dependent: :destroy
	has_many :notifications, dependent: :destroy
	has_one :spec, dependent: :destroy
  has_many :publications, dependent: :destroy

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

  def self.contacts_adder_temp
    @projects = Project.all

    @projects.each do |project|
      if project.leader_id.present?
        leader = User.find(project.leader_id)
        members = project.users.where.not(id: leader.id)

        members.each do |member|
          contact = Contact.where(care_manager_id: leader.id, service_provider_id: member.id)
          contact_reverse = Contact.where(care_manager_id: member.id, service_provider_id: leader.id)

          unless contact.present? || contact_reverse.present?
            Contact.create!(care_manager_id: leader.id, service_provider_id: member.id)
          end
        end
      end
    end
  end

  private

  def create_spec
    spec = Spec.create(project_id: self.id,publisher_id: self.leader_id)
  end
  
end
