require 'cpf_faker'

FactoryGirl.define do
  factory :client_bank do
    owner_account {Faker::Name.name}
    bank_name {Faker::Bank.name}
    bank_code {Faker::Number.number(3)}
    agency_number {Faker::Number.number(5)}
    account_number {Faker::Number.number(5)}
    agency_name Faker::Bank.swift_bic
    cnpj {Faker::CNPJ.numeric}
    operation {Faker::Number.number(2)}
    association :account_bank_type
  end
end
