class PaymentScope < ActiveRecord::Base
	has_and_belongs_to_many :contract_payments
end
