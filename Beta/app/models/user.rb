class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :memberships
  has_many :projects, through: :memberships
  has_many :messages
  has_many :documents
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attribute :email, :string

  after_create :welcome_email

  def project
    self.projects.first
  end

  def welcome_email
    UserMailer.welcome(self).deliver_now if self.username.present?
  end

end
