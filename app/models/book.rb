class Book < ActiveRecord::Base
	belongs_to :user
	
	default_scope -> { order('created_at DESC')}
	scope :approved, -> { where(approved: true) }
	scope :pending_approval, -> { where(approved: false) }

	validates :title, presence: true
	validates :isbn, presence: true, length: { maximum: 14 }
	validates :user_id, presence: true

	def approve!
    self.approved = true
    self.save
  end

end
