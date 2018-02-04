class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :memberships
  has_many :projects, through: :memberships
  has_many :documentships, dependent: :destroy
  has_many :documents, through: :documentships
  has_many :messages
  has_many :conversation_users
  has_many :conversations, through: :conversation_users
  has_many :notifications, dependent: :destroy
  has_many :readmarks
  has_many :reportings
  has_many :reporting_readmarks
  has_many :publications
  has_many :publication_readmarks
  has_many :publication_comments
  has_many :publication_comment_readmarks
  has_many :care_manager_contacts, class_name: 'Contacts', foreign_key: 'care_manager_id', dependent: :destroy
  has_many :service_provider_contacts, class_name: 'Contacts', foreign_key: 'service_provider_id', dependent: :destroy
  has_one :timeline



  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attribute :email, :string

  validates_uniqueness_of :email
  before_save :ensure_authentication_token
  after_create :welcome_email, :create_timeline

  def ensure_authentication_token
  	if authentication_token.blank?
  		self.authentication_token = generate_authentication_token
  	end
  end

  def deleted?
    self.deleted_at.present?
  end

  def unregistered?
    self.username.blank?
  end

  def self.add_token
    users = User.all
    users.each do |user|
      user.update(authentication_token: Devise.friendly_token)  if user.authentication_token.blank?
    end
  end

  def project
    self.projects.first
  end

  def welcome_email
    UserMailer.welcome(self).deliver_later if self.username.present?
  end

  # instead of deleting, indicate the user requested a delete & timestamp it
  def soft_delete
    update_attribute(:deleted_at, Time.current)
  end

  # ensure user account is active
  def active_for_authentication?
    super && !deleted_at
  end

  # provide a custom message for a deleted account
  def inactive_message
    !deleted_at ? super : :deleted_account
  end

  def online?
    !Redis.new.get("user_#{self.id}_online").nil?
  end

  def name_else_email
    self.username.present? ? self.username : self.email
  end

  def self.morning_notification
    #swithching from writing all urls to just sending link to timelines
    reporting_readmarked_users = User.joins(:reporting_readmarks).where(reporting_readmarks: {read: false})
    puts reporting_readmarked_users
    publication_readmarked_users = User.joins(:publication_readmarks).where(publication_readmarks: {read: false})
    puts publication_readmarked_users
    publication_comment_readmarked_users = User.joins(:publication_comment_readmarks).where(publication_comment_readmarks: {read: false})
    puts publication_comment_readmarked_users

    users_with_duplicates = reporting_readmarked_users + publication_readmarked_users + publication_comment_readmarked_users
    puts "users with duplicates"
    puts users_with_duplicates.map {|user| user.id }
    users_uniq = users_with_duplicates.uniq
    puts "users after uniq"
    puts users_uniq.map {|user| user.id }

    users_uniq.each do |user|
      unless user.deleted_at.present?
        UserMailer.morning_notification_email(user).deliver_now
        puts user.class.name
        puts "email sent to"
        puts user.id 
      end
    end

    #if @users.present?
    #  ids = Array.new
    #  @users.each do |user|
    #    unless ids.include?(user.id.to_i) || user.deleted_at.present?
    #      ids << user.id.to_i
    #      UserMailer.morning_notification_email(user).deliver_now
    #    end
    #  end  
    #end
  end

  #temporary function, used to add timelines to users that already exist
  def self.add_timeline
    users = User.all

    users.each do |user|
      Timeline.create!(user_id: user.id) unless user.timeline.present?
    end
  end

  private

  def generate_authentication_token
  	loop do
  		token = Devise.friendly_token
  		break token unless User.where(authentication_token: token).first
  	end
  end

  def create_timeline
    Timeline.create!(user_id: self.id)
  end


end
