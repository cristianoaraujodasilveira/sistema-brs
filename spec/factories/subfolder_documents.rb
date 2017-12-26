FactoryGirl.define do
	factory :subfolder_document do
		name {Faker::Name.name}
		association :client_document_type
	end
end
