class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :memberships
  has_many :projects, through: :memberships
  has_many :messages
  has_many :documents
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def project
    self.projects.first
  end

end
