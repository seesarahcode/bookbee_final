class Book < ActiveRecord::Base
	belongs_to :user
	has_many :reviews

	ratyrate_rateable "book_rating"
	acts_as_taggable_on :tags

	accepts_nested_attributes_for :reviews
	
	default_scope -> { order('created_at DESC')}
	scope :approved, -> { where(approved: true) }
	scope :pending_approval, -> { where(approved: false) }

	validates :title, :user_id, :cover, presence: true
	validates :isbn, presence: true, length: { maximum: 17 }

	mount_uploader :cover, CoverUploader

	def approve!
	  self.approved = true
	  self.save
  end

  def deactivate!
  	self.deactived = true
  	self.save
  end

end
