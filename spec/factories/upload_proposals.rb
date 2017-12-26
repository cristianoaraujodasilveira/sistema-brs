FactoryGirl.define do
  factory :upload_proposal do
    association :proposal
    file { File.new("#{Rails.root}/spec/support/files/arquivo.pdf") }
  end
end
