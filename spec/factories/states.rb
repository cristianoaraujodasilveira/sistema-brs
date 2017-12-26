FactoryGirl.define do
  factory :state do
    name {Faker::Address.state}
    acronym {Faker::Address.state_abbr}
  end
end
