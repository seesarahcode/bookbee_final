class Invitation < ActiveRecord::Base

	validates_presence_of :recipient_email, :recipient_name
	validate :recipient_is_not_registered

	private

	def recipient_is_not_registered
	  errors.add :recipient_email, 'is already registered' if User.find_by_email(recipient_email)
	end

end
