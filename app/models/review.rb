class Review < ActiveRecord::Base
	belongs_to :book

	validates :title, :text, :user_id, :book_id, presence: true
end
