FactoryGirl.define do
    factory :library do
        association :library_category
        title {Faker::Name.name}
        author_name {Faker::Name.name}
        edition {Faker::Name.name}
        year_publication {Faker::Number.number(4)}
        publishing_company {Faker::Name.name}
        isbn {Faker::Name.name}
        link {Faker::Internet.domain_name}
        sanctioned_date {Faker::Date.between(7.days.ago, Date.today)}
        court {Faker::Name.name}
        association :state
        association :city
        document_name {Faker::Name.name}
        process_number {Faker::Number.number(8)}
        process_date {Faker::Date.between(7.days.ago, Date.today)}
        legislative_reference {Faker::Name.name}
        description {Faker::Lorem.paragraph}
    end
end
