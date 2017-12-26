FactoryGirl.define do
  factory :client_document do
    document {File.new("#{Rails.root}/spec/support/files/logo.png")}
    due_date {Faker::Date.forward(45)}
    
    association :client_document_type
    association :client_document_status
    association :client_document_notification
  end
end
