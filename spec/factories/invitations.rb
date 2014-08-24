# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invitation do
    sender_id 1
    recipient_email "MyString"
    token "MyString"
    sent_at "2014-08-24 04:20:16"
    new "MyString"
  end
end
