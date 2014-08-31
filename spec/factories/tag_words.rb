# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tag_word do
    book_id 1
    word "MyString"
  end
end
