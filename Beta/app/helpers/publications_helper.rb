module PublicationsHelper

	def link_to_publication_read(publication, user)
	  publication_readmark = publication.readmarks.where(user_id: user.id)
	  url = publication_publication_readmark_path(publication, publication_readmark)

	  if publication_readmark.read
	    link_to( 'mark as unread', url, {
	      method: 'PUT',
	      remote: true,
	      class: 'btn btn-danger',
	    })
	  else
	    link_to('mark as read', url, {
	      method: 'PUT',
	      remote: true,
	      class: 'btn btn-primary',
	    })
	  end
	end

end
