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

FactoryGirl.define do
	factory :book do
		sequence(:title) { |n| "My Memoirs, Part #{n}"}
		sequence(:author) { |n| "Me"}
		sequence(:isbn) { |n| "971-62161-012#{n}"}
		user
	end
end