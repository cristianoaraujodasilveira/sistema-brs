class Attachment < ActiveRecord::Base
	audited

	belongs_to :attachmentable, :polymorphic => true

	has_attached_file :attachment,
	:storage => :s3,
	:url => ":s3_domain_url",
	:path => ":class/:attachment/:id_partition/:style/:filename"
	do_not_validate_attachment_file_type :attachment
	
end
