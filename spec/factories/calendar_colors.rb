FactoryGirl.define do
  factory :calendar_color do
    name {Faker::Name.name}
    code {Faker::Color.hex_color}
  end
end
