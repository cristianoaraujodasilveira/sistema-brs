FactoryGirl.define do
	factory :attachment do
		association :attachmentable, factory: :profile
		
		attachment { File.new("#{Rails.root}/spec/support/files/logo.jpg") }
		type {Faker::Number.number(1)}
	end
end
