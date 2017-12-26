class Organ < ActiveRecord::Base
	audited
	
	belongs_to :city
	belongs_to :state
	belongs_to :sphere
	belongs_to :organ

	has_many :sectors, dependent: :destroy
	accepts_nested_attributes_for :sectors, allow_destroy: true

	has_many :phone_sectors
	accepts_nested_attributes_for :phone_sectors, allow_destroy: true

	has_many :email_sectors
	accepts_nested_attributes_for :email_sectors, allow_destroy: true

	has_many :organs, dependent: :destroy
	accepts_nested_attributes_for :organs, allow_destroy: true

	has_many :electronic_portals, :validate => false, dependent: :destroy
	accepts_nested_attributes_for :electronic_portals, allow_destroy: true, :reject_if => proc { |attrs| attrs['value'].blank?}

	validates_presence_of :sphere_id, :name, :phone, :cnpj, :zipcode, :address, :district, :number, :state_id, :city_id
	validates_uniqueness_of :cnpj

	has_many :observations, :as => :observationtable, dependent: :destroy
	accepts_nested_attributes_for :observations, allow_destroy: true, :reject_if => proc { |attrs| attrs[:observation].blank? }

	has_and_belongs_to_many :portals

	has_many :pieces, dependent: :destroy

	def get_complete_address
		text = ""
		if self.address != nil
			text += self.address+', '
		end
		if self.number != nil
			text += self.number+', '
		end
		if self.district != nil
			text += self.district+', '
		end
		if self.complement != nil
			text += self.complement+', '
		end
		if self.city != nil
			text += self.city.name+', '
		end
		if self.state != nil
			text += self.state.name
		end
		return text
	end

end 
