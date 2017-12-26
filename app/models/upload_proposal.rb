class UploadProposal < ActiveRecord::Base
	audited

	belongs_to :proposal

	has_attached_file :file,
	:storage => :s3,
	:url => ":s3_domain_url",
	:path => ":class/:attachment/:id_partition/:style/:filename"
	do_not_validate_attachment_file_type :file

	validates_presence_of :file
end
