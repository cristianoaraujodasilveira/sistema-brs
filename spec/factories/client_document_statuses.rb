FactoryGirl.define do
  factory :client_document_status do
    name {Faker::Name.name}
    color {Faker::Color.hex_color}
  end
end
