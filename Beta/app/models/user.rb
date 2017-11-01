class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :memberships
  has_many :projects, through: :memberships
  has_many :documents
  has_many :messages
  has_many :conversation_users
  has_many :conversations, through: :conversation_users
  has_many :notifications, dependent: :destroy


  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attribute :email, :string

  validates_uniqueness_of :email
  after_create :welcome_email

  def project
    self.projects.first
  end

  def welcome_email
    UserMailer.welcome(self).deliver_now if self.username.present?
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
    #so far, only taking all the unread notifications. later on, check by date of creation
    @users = User.joins(:notifications).where(notifications: {read: false})

    if @users.present?
      @users.each do |user|
        UserMailer.morning_notification_email(user).deliver_later
      end
    end
  end

end
