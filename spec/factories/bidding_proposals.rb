require 'cpf_faker'

FactoryGirl.define do
    factory :bidding_proposal do
        association :bidding
        association :price_offer
        another_price_offer {Faker::Number.number(3)}
        association :registration_form
        technical_offer false
        association :judgment_form
        quoted_value {Faker::Number.number(3)}
        discount_percent {Faker::Number.number(3)}
        item_number {Faker::Number.number(3)}
        description {Faker::Company.buzzword}
        quantity 1
        unitary_value {Faker::Number.number(3)}
        total_value {Faker::Number.number(3)}
        global_value {Faker::Number.number(3)}
        partner_rank_text {Faker::Name.name}
        association :partner_rank
        association :participation_result
        association :competition_status
        auctioned_value {Faker::Number.number(3)}
        association :unit
        traded_value {Faker::Number.number(3)}
        bidder_name {Faker::Name.name}
        representative_name {Faker::Name.name}
        cnpj {Faker::CNPJ.pretty}
        past_due {Faker::Number.number(3)}
        association :bidder_status
        another_bidder_status {Faker::Name.name}
        association :provenance
        association :country
        site {Faker::Internet.domain_name}
    end
end
