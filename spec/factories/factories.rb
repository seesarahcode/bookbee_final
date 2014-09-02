FactoryGirl.define do
	factory :image do |img|
		img.image  fixture_file_upload( 'cover.jpg')
	end
end