class Book < ActiveRecord::Base
	belongs_to :user
	has_many :reviews
  has_many :tag_words

	ratyrate_rateable "book_rating"
	acts_as_taggable_on :tags

	accepts_nested_attributes_for :reviews
	
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

  def self.search(search)
	  if search
	    find(:all, :conditions => ['books.title LIKE ?
            OR books.author LIKE ?
            OR books.isbn LIKE ?
            OR books.last_avg_rating LIKE ?
            OR tag_words.word LIKE ?
            OR reviews.title LIKE?
            OR reviews.text LIKE?
            OR reviews.fave_quote LIKE?',
            "%#{search}%",
            "%#{search}%",
            "%#{search}%",
            "%#{search}%",
            "%#{search}%",
            "%#{search}%",
            "%#{search}%",
            "%#{search}%"],
            :include => [:reviews, :tag_words]
          )
	  else
	    scoped
	  end
	end

end