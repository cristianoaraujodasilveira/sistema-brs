FactoryGirl.define do
  factory :communication do
    user nil
    communication_status nil
    department_notified nil
    client nil
    organ nil
    modalidate nil
    subject "MyString"
    description "MyText"
  end
end
