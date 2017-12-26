require 'cpf_faker'

FactoryGirl.define do
  factory :proposal do
    association :client 
    association :proposal_situation 
    association :visits_report
    association :user
    social_name {Faker::Company.name}
    fantasy_name {Faker::Company.buzzword}
    cnpj {Faker::CNPJ.numeric}
    title {Faker::Name.title}
    observation {Faker::Lorem.paragraph}
    notes {Faker::Lorem.paragraph}
    proposed_value {Faker::Number.decimal(2)}
    closed_value {Faker::Number.decimal(2)}
    minimum_value {Faker::Number.decimal(2)}
    proposed_percentage {Faker::Number.decimal(2)}
    closed_percentage {Faker::Number.decimal(2)}
    minimum_percentage {Faker::Number.decimal(2)}
    commission_percentage {Faker::Number.decimal(2)}

    after(:build) do |proposal|
        proposal.users << build(:user)
    end
  end
end
