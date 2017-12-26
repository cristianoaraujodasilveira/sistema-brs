FactoryGirl.define do
	factory :notification do
		association :action_notification
		association :area_notification
		text {Faker::Name.name}
	end
end
