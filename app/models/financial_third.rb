class FinancialThird < ActiveRecord::Base
	belongs_to :financial_third_service
	belongs_to :financial
	belongs_to :third_type
	belongs_to :third
	belongs_to :lawyer

	validates_presence_of :financial_id, :third_type_id, :financial_third_service_id, :quantity, :value, :date

	has_many :observations, :as => :observationtable, dependent: :destroy
	accepts_nested_attributes_for :observations, allow_destroy: true, :reject_if => proc { |attrs| attrs[:observation].blank? }

	def get_id_last_observation
		last_id = 0
		self.observations.each do |ob|
			if ob.id != nil
				last_id = ob.id
			end
		end
		return last_id
	end
end
