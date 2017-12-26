FactoryGirl.define do
  factory :contract_model do
    draft_contact {Faker::Lorem.paragraph}
  end
end
