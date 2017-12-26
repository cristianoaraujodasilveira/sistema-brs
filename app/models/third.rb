class Third < ActiveRecord::Base
	audited

	attr_accessor :third_type

	belongs_to :diligent_profile
	belongs_to :third_type

	has_many :emails, :as => :emailtable, dependent: :destroy
	accepts_nested_attributes_for :emails, allow_destroy: true, :reject_if => proc { |attrs| attrs[:email].blank? }

	has_many :phones, :as => :phonetable, dependent: :destroy
	accepts_nested_attributes_for :phones, allow_destroy: true, :reject_if => proc { |attrs| attrs[:phone].blank? }

	has_one :responsible, :as => :responsibletable, dependent: :destroy
	accepts_nested_attributes_for :responsible

	has_one :address, :as => :addresstable, dependent: :destroy
	accepts_nested_attributes_for :address

	has_many :attachments, :as => :attachmentable, dependent: :destroy
	accepts_nested_attributes_for :attachments, allow_destroy: true, :reject_if => proc { |attrs| attrs[:attachment].blank? }

	has_many :observations, :as => :observationtable, dependent: :destroy
	accepts_nested_attributes_for :observations, allow_destroy: true, :reject_if => proc { |attrs| attrs[:observation].blank? }

	validates_presence_of :register_number

	validates_presence_of :diligent_profile_id, if: Proc.new { |third| third.third_type_id == 5 }

	def as_json(options = {})
		{
			:id => self.id,
			:register_number => self.register_number,
			:name => self.get_name,
			:social_name => self.get_social_name,
			:fantasy_name => self.get_fantasy_name,
		}
	end

	def get_name
		if self.name
			return self.name
		end
		return ''
	end

	def get_fantasy_name
		if self.fantasy_name
			return self.fantasy_name
		end
		return ''
	end

	def get_social_name
		if self.social_name
			return self.social_name
		end
		return ''
	end
end
