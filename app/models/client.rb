class Client < ActiveRecord::Base
	audited

	attr_accessor :step, :delete_logo, :delete_stamp
	before_validation { logo.clear if delete_logo == '1' }
	before_validation { stamp.clear if delete_stamp == '1' }
	before_validation :delete_from_branchs
	
	has_one :client_segment, :validate => false, dependent: :destroy
	accepts_nested_attributes_for :client_segment

	has_one :client_contability, :validate => false, dependent: :destroy
	accepts_nested_attributes_for :client_contability
	
	has_many :proposals
	has_many :visits_reports
	
	# Cliente pai ao adicionar filial
	belongs_to :client

	belongs_to :proposal

	has_many :portals, dependent: :destroy

	validates_uniqueness_of :cnpj, :case_sensitive => false, :message=>"já existe para outro cliente"

	belongs_to :client_company_size
	belongs_to :client_periodicity
	belongs_to :client_type
	belongs_to :client_status
	belongs_to :client_class

	has_and_belongs_to_many :users

	# Selecionar os clientes
	has_many :client_clients, dependent: :destroy
	accepts_nested_attributes_for :client_clients, allow_destroy: true

	# Documentos
	has_many :client_documents, dependent: :destroy
	accepts_nested_attributes_for :client_documents, allow_destroy: true, :reject_if => proc { |attrs| attrs['id'].blank? && (attrs['document'].blank? || attrs['due_date'].blank? || attrs['client_document_notification_id'].blank?) }

	# Filiais
	has_many :clients, dependent: :destroy
	accepts_nested_attributes_for :clients, allow_destroy: true

	# Contatos
	has_many :client_contacts, :validate => false, dependent: :destroy
	accepts_nested_attributes_for :client_contacts, allow_destroy: true, :reject_if => proc { |attrs| attrs['zipcode'].blank? || attrs['address'].blank? || attrs['number'].blank? || attrs['responsible_name'].blank? || attrs['state_id'].blank? || attrs['city_id'].blank?}
	validates_associated :client_contacts, if: Proc.new { |client| client.step == 6 || client.step == "6" }

	# Contas bancárias
	has_many :client_banks, :validate => false, dependent: :destroy
	accepts_nested_attributes_for :client_banks, allow_destroy: true
	validates_associated :client_banks, if: Proc.new { |client| client.step == 5 || client.step == "5" }
	
	has_attached_file :logo,
	:storage => :s3,
	:url => ":s3_domain_url",
	:path => ":class/:attachment/:id_partition/:style/:filename"
	validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/

	has_attached_file :stamp,
	:storage => :s3,
	:url => ":s3_domain_url",
	:path => ":class/:attachment/:id_partition/:style/:filename"
	validates_attachment_content_type :stamp, content_type: /\Aimage\/.*\z/

	validates_presence_of :social_name, :fantasy_name, :cnpj, if: Proc.new { |client| client.step == 1 || client.step == "1" }

	has_many :biddings, :foreign_key => "catch_client_id", :class_name => "Bidding"
	accepts_nested_attributes_for :biddings, allow_destroy: true

	private

	def delete_from_branchs
		if self && self.clients.length > 0
			self.clients.each do |client|
				if client.delete_logo == '1' || client.delete_logo == 1
					client.logo.clear
				end
				if client.delete_stamp == '1' || client.delete_stamp == 1
					client.stamp.clear
				end
			end
		end
	end

end
