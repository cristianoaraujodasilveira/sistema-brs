class FinancialTicket < ActiveRecord::Base
	belongs_to :financial

	has_attached_file :ticket,
	:storage => :s3,
	:url => ":s3_domain_url",
	:path => ":class/:attachment/:id_partition/:style/:filename"
	do_not_validate_attachment_file_type :ticket
end
