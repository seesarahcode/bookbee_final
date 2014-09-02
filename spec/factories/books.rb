FactoryGirl.define do
	factory :book do
		sequence(:title) { |n| "My Memoirs, Part #{n}"}
		sequence(:author) { |n| "Me"}
		sequence(:isbn) { |n| "971-62161-012#{n}"}
		sequence(:cover) { [ FactoryGirl.create(:image) ] }
		user
	end
end