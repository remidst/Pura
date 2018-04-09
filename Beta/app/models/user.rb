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

  mount_uploader :avatar, AvatarUploader

  attribute :email, :string

  validates_uniqueness_of :email

  validates_format_of :email, with: Devise::email_regexp

  validates_integrity_of  :avatar
  validates_processing_of :avatar



  before_save :ensure_authentication_token
  after_create :welcome_email, :create_timeline, :generate_color

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


  def name_else_email
    self.username.present? ? self.username : self.email
  end

  def self.morning_notification
    #swithching from writing all urls to just sending link to timelines
    reporting_readmarked_users = User.joins(:reporting_readmarks).where(reporting_readmarks: {read: false})
    publication_readmarked_users = User.joins(:publication_readmarks).where(publication_readmarks: {read: false})
    publication_comment_readmarked_users = User.joins(:publication_comment_readmarks).where(publication_comment_readmarks: {read: false})

    users_with_duplicates = reporting_readmarked_users + publication_readmarked_users + publication_comment_readmarked_users
    users_uniq = users_with_duplicates.uniq

    users_uniq.each do |user|
      unless user.deleted_at.present?
        UserMailer.morning_notification_email(user).deliver_now
      end
    end

  end

  #temporary function to add color to each existing user
  def self.avatar_color_generation
  	@users = User.all
  	palette = ['#C67D28', '#3D9BF3', '#4AF34B', '#EE59A6', '#34F0E0', '#B19C9B', '#F07891', '#6F9A4E', '#EDB3F5', '#ED655F', '#59EF9B', '#2BFE46', '#A3D4F5', '#41988E', '#A587F6', '#B5A626', '#BBE5CE', '#4DA419', '#B3F665', '#EA5D25', '#E19B73', '#8E8CBC', '#DF788C', '#F9AE1B', '#F475E1', '#898D66', '#4BBF92', '#BCEF8E', '#A4C791', '#AD7895', '#3BC359', '#DEC6DC', '#4491BB', '#ECCCB3', '#9FC348', '#BC79BD', '#A6A055', '#B5E925', '#ECB155', '#7993A0', '#EADA6E', '#F19DBF', '#3EC8EA', '#85F322', '#58956E', '#3BE4F8', '#B77776', '#FBC32D', '#71C47A', '#C57346', '#50AFBB', '#67E7EE', '#F04885', '#E495F1', '#B4BC9F', '#AC8455', '#B487FB', '#ECC23A', '#D9B06D', '#58F4C7', '#BA9DEF', '#CE73A5', '#F4B2A3', '#E68B1A', '#F17D59', '#53A042', '#6BBEA6', '#C5A1D2', '#C6CBF5', '#EE7513', '#E47774', '#839C29', '#91B2A8', '#8BAADC', '#E95F7D', '#57B2E6', '#9DC877', '#ED8C4C', '#E5B9BA', '#90CED4', '#ECD19E', '#B9BD4F', '#22D042', '#54EE81', '#439D5E', '#A8B319', '#8C91F0', '#97F17D', '#43A26B', '#C89C15', '#A9ADBD', '#E274BD', '#85E7BF', '#C2A13F', '#F14D63', '#F1D935', '#7BCC69', '#D2C977', '#E56C9B', '#F05B48', '#BB73D2', '#F0A364', '#B2D939', '#B38774', '#CCD318', '#BA8739', '#DFB087', '#CC9497', '#74DF32', '#5FC32E', '#7BA0EC', '#B5AC83', '#8EDCCA', '#F08C70', '#AC91A4', '#E47C2D', '#8797F3', '#2ACD7D', '#C0E974', '#77AA72', '#9E8A1A', '#49BEB7', '#B9E5F3', '#E36B37', '#C4CDCA', '#E9C0ED', '#3E96DC', '#CDC98D', '#6A8CBE', '#A183CD', '#87869E', '#C68B51', '#73AB20', '#65B543', '#958977', '#258EB7', '#B782AF', '#A87D85', '#7C8E57', '#EC9CAB', '#E8C25B', '#DBC845', '#90DB22', '#DB5FBB', '#919AD9', '#A5B964', '#7FEEA3', '#E0B2C6', '#779978', '#7CD45C', '#ACA169', '#E79B87', '#9D8465', '#7AB992', '#35A633', '#46A35A', '#96BED5', '#D26B3C', '#A698B9', '#9FC29F', '#278DDE', '#CAB0A1', '#5F8CE5', '#A88E57', '#5DAACB', '#9F8E36', '#0EA827', '#BBCE88', '#9DE0A6', '#EB9ED0', '#6DE8D8', '#8DC957', '#D07C76', '#8E7DD6', '#13EDAE', '#48DB29', '#EA666F', '#A88E4F', '#BC8723', '#5F9B8F', '#94AD74', '#DF705F', '#E480EC', '#CE7236', '#C37758', '#EB8C5E', '#EBCA7D', '#E99B99', '#D6D6EE', '#F6C823', '#977DAB', '#8491AC', '#C77E96', '#3DA27B', '#3AB097', '#D78D45', '#E19ADC', '#DC4DA7', '#E9A140', '#82DD89', '#51BF81', '#A9A28C', '#AEB1DE', '#ECAE2F', '#E9BCB4', '#45DEAC', '#47E85D', '#76D3EE', '#9DE053', '#DA6949', '#7EA924']

  	@users.each do |user|
  		user.avatar_color = palette.sample
  		user.save!
  	end

  end


  private

  def generate_authentication_token
  	loop do
  		token = Devise.friendly_token
  		break token unless User.where(authentication_token: token).first
  	end
  end

  def generate_color
  	palette = ['#C67D28', '#3D9BF3', '#4AF34B', '#EE59A6', '#34F0E0', '#B19C9B', '#F07891', '#6F9A4E', '#EDB3F5', '#ED655F', '#59EF9B', '#2BFE46', '#A3D4F5', '#41988E', '#A587F6', '#B5A626', '#BBE5CE', '#4DA419', '#B3F665', '#EA5D25', '#E19B73', '#8E8CBC', '#DF788C', '#F9AE1B', '#F475E1', '#898D66', '#4BBF92', '#BCEF8E', '#A4C791', '#AD7895', '#3BC359', '#DEC6DC', '#4491BB', '#ECCCB3', '#9FC348', '#BC79BD', '#A6A055', '#B5E925', '#ECB155', '#7993A0', '#EADA6E', '#F19DBF', '#3EC8EA', '#85F322', '#58956E', '#3BE4F8', '#B77776', '#FBC32D', '#71C47A', '#C57346', '#50AFBB', '#67E7EE', '#F04885', '#E495F1', '#B4BC9F', '#AC8455', '#B487FB', '#ECC23A', '#D9B06D', '#58F4C7', '#BA9DEF', '#CE73A5', '#F4B2A3', '#E68B1A', '#F17D59', '#53A042', '#6BBEA6', '#C5A1D2', '#C6CBF5', '#EE7513', '#E47774', '#839C29', '#91B2A8', '#8BAADC', '#E95F7D', '#57B2E6', '#9DC877', '#ED8C4C', '#E5B9BA', '#90CED4', '#ECD19E', '#B9BD4F', '#22D042', '#54EE81', '#439D5E', '#A8B319', '#8C91F0', '#97F17D', '#43A26B', '#C89C15', '#A9ADBD', '#E274BD', '#85E7BF', '#C2A13F', '#F14D63', '#F1D935', '#7BCC69', '#D2C977', '#E56C9B', '#F05B48', '#BB73D2', '#F0A364', '#B2D939', '#B38774', '#CCD318', '#BA8739', '#DFB087', '#CC9497', '#74DF32', '#5FC32E', '#7BA0EC', '#B5AC83', '#8EDCCA', '#F08C70', '#AC91A4', '#E47C2D', '#8797F3', '#2ACD7D', '#C0E974', '#77AA72', '#9E8A1A', '#49BEB7', '#B9E5F3', '#E36B37', '#C4CDCA', '#E9C0ED', '#3E96DC', '#CDC98D', '#6A8CBE', '#A183CD', '#87869E', '#C68B51', '#73AB20', '#65B543', '#958977', '#258EB7', '#B782AF', '#A87D85', '#7C8E57', '#EC9CAB', '#E8C25B', '#DBC845', '#90DB22', '#DB5FBB', '#919AD9', '#A5B964', '#7FEEA3', '#E0B2C6', '#779978', '#7CD45C', '#ACA169', '#E79B87', '#9D8465', '#7AB992', '#35A633', '#46A35A', '#96BED5', '#D26B3C', '#A698B9', '#9FC29F', '#278DDE', '#CAB0A1', '#5F8CE5', '#A88E57', '#5DAACB', '#9F8E36', '#0EA827', '#BBCE88', '#9DE0A6', '#EB9ED0', '#6DE8D8', '#8DC957', '#D07C76', '#8E7DD6', '#13EDAE', '#48DB29', '#EA666F', '#A88E4F', '#BC8723', '#5F9B8F', '#94AD74', '#DF705F', '#E480EC', '#CE7236', '#C37758', '#EB8C5E', '#EBCA7D', '#E99B99', '#D6D6EE', '#F6C823', '#977DAB', '#8491AC', '#C77E96', '#3DA27B', '#3AB097', '#D78D45', '#E19ADC', '#DC4DA7', '#E9A140', '#82DD89', '#51BF81', '#A9A28C', '#AEB1DE', '#ECAE2F', '#E9BCB4', '#45DEAC', '#47E85D', '#76D3EE', '#9DE053', '#DA6949', '#7EA924']
  	self.avatar_color = palette.sample
  	self.save!
  end

  def avatar_size_validation
    errors[:avatar] << "500KB以下のファイルを選択してください" if avatar.size > 0.5.megabytes
  end

  def create_timeline
    Timeline.create!(user_id: self.id)
  end


end
