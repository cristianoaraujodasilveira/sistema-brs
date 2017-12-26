FactoryGirl.define do
	factory :client_segment do
		association :client
		name {Faker::Name.name}
		products_services {Faker::Lorem.paragraph}

		trait :with_words_keys do
			after :build do |client_segment|
				client_segment.words_keys << build(:words_key, :client_segment => client_segment)
			end
		end
	end
end
