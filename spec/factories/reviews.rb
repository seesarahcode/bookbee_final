FactoryGirl.define do
	factory :review do
		sequence(:title) { |n| "#{n} Out of 5 Stars" }
		sequence(:text) { |n| "There were lots of good parts, and lots of bad parts." }
		sequence(:fave_quote) { |n| "Beautiful quote goes here." }
		sequence(:user_id) { |n| "#{n}" }
		book
	end
end