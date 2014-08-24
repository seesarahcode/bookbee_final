class Review < ActiveRecord::Base
	belongs_to :book

	validates :title, :text, :user_id, presence: true
end
