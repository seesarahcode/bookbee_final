FactoryGirl.define do
	factory :user do
		sequence(:name)  { |n| "Giles the #{n}" }
    sequence(:email) { |n| "librarian_#{n}@sunnydale.edu"}
    password "sl4yerf1rst"
    password_confirmation "sl4yerf1rst"
    
		factory :admin do
			admin true
		end
	end
end