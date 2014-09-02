FactoryGirl.define do
	factory :invitation do
		sequence(:sender_id) { |n| "#{n}" }
		sequence(:recipient_name) { |n| "William Shakespeare" }
		sequence(:recipient_email) { |n| "friend@example.com" }
		sequence(:sent_at) { |n| Time.now }
	end
end