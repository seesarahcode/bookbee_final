class User < ActiveRecord::Base
  has_many :books
  has_many :follows, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :blocked_users, dependent: :destroy


  ratyrate_rater
  accepts_nested_attributes_for :follows
  accepts_nested_attributes_for :blocked_users

	before_save { self.email = email.downcase }
	before_create :create_remember_token

	validates :name, presence: true, length: { maximum: 50 }
	
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :email, presence: true, 
  	uniqueness: { case_sensitive: false },
  	format: { with: VALID_EMAIL_REGEX }

	has_secure_password
  validate :validate_password_length

  def User.new_remember_token
  	SecureRandom.urlsafe_base64
  end

  def User.digest(token)
  	Digest::SHA1.hexdigest(token.to_s)
  end

  def feed
    # Early prototype
    Book.where("user_id = ?", id)
  end

  def admin?
    true if self.admin == :true
  end

  def validate_password_length
    !new_record? || password.length >= 6
  end

  private

  	def create_remember_token
  		self.remember_token = User.digest(User.new_remember_token)
  	end

end
