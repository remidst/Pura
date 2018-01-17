module ProjectsHelper

	def publication_readmark_count(publication)
		readmarks = Publication_Readmark.where(publication_id: publication.id, read: true)
		readmarks.count
	end

	def publication_readmark_list(publication)
		readmarks = Publication_Readmark.where(publication_id: publication.id, read: true)
		readmarks.map{ |readmark| readmark.user.username }.join(',')
	end
end
