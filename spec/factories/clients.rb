require 'cpf_faker'

FactoryGirl.define do
  factory :client do
    logo {File.new("#{Rails.root}/spec/support/files/logo.png")}
    stamp {File.new("#{Rails.root}/spec/support/files/carimbo.png")}
    social_name {Faker::Company.name}
    fantasy_name {Faker::Company.buzzword}
    cnpj {Faker::CNPJ.numeric}
    site {Faker::Internet.domain_name}
    municipal_registration {Faker::Company.swedish_organisation_number}
    state_registration {Faker::Company.swedish_organisation_number}
    bid_participant true

    association :client_company_size
    association :client_periodicity
    association :client_type
    association :client_status

    after(:build) do |account|
        create_list(:client_document_type,3)
        create_list(:client_document_status,4)
        create_list(:client_document_notification,6)
        create_list(:client_contact_type,3)
    end

    trait :with_branchs do
        after :build do |client|
            client.clients << build(:client, :client => client)
        end
    end
end
end
