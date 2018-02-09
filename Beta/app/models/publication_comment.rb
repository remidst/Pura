class PublicationComment < ApplicationRecord
  belongs_to :publication
  belongs_to :publisher, class_name: "User"
  has_many :publication_comment_attachments, dependent: :destroy
  has_many :publication_comment_readmarks, dependent: :destroy
  
  accepts_nested_attributes_for :publication_comment_attachments

  after_create :create_publication_comment_readmarks

  private

  def create_publication_comment_readmarks
  	publication = self.publication
  	project = publication.project
    publisher = self.publisher
  	users_but_publisher = project.users.where.not(id: publisher.id)

  	users_but_publisher.each do |user|
  		self.publication_comment_readmarks.create!(user_id: user.id, read: false)
  	end

    #create a readmark as read for the publisher
    self.publication_comment_readmarks.create!(user_id: publisher.id, read: true)
  end
end
