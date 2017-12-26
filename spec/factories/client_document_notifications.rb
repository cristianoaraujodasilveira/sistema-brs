FactoryGirl.define do
	factory :client_document_notification do
		days {Faker::Number.number(3)}
	end
end
