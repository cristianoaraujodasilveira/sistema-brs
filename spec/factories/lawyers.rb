require 'cpf_faker'

FactoryGirl.define do
    factory :lawyer do
        association :lawyer_type
        name {Faker::Name.name}
        office {Faker::Company.profession}
        created_date {Faker::Date.between(7.days.ago, Date.today)}
        cpf {Faker::CPF.pretty}
        cnpj {Faker::CNPJ.pretty}
        oab {Faker::Number.number(6)}
        municipal_registration {Faker::Number.number(6)}
        association :honorary_form
        association :state
        association :city
        honorary_value {Faker::Number.number(3)}

        after :build do |lawyer|
            lawyer.phones << build(:phone)
            lawyer.emails << build(:email)
        end
    end
end
