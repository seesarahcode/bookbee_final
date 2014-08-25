# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :follow do
    user_id 1
    title "MyString"
    ratings false
    reviews false
    book_id 1
  end
end
