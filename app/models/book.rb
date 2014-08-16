class Book < ActiveRecord::Base
	belongs_to :user
	default_scope -> { order('created_at DESC')}
	validates :title, presence: true
	validates :isbn, presence: true, length: { maximum: 14 }
	validates :user_id, presence: true
end
