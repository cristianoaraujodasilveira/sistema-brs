class OfficialDiary < ActiveRecord::Base
	audited

	belongs_to :user
	belongs_to :sphere

	has_one :address, :as => :addresstable, dependent: :destroy
	accepts_nested_attributes_for :address

	has_many :responsibles, :as => :responsibletable, dependent: :destroy
	accepts_nested_attributes_for :responsibles, allow_destroy: true

	has_many :observations, :as => :observationtable, dependent: :destroy
	accepts_nested_attributes_for :observations, allow_destroy: true, :reject_if => proc { |attrs| attrs[:observation].blank? }
	
	validates_presence_of :name, 
	:social_name, 
	:user_id,
	:cnpj
	
end
