class Document < ActiveRecord::Base
	def self.initialize(dept)
		@document = Document.find_by(uploader_id: '1')
		raise
	end
end