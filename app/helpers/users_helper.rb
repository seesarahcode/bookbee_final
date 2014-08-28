module UsersHelper

	def gravatar_for(user)
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
		image_tag(gravatar_url, alt: user.name, class: "gravatar")
	end

	def follows_exist?(user)
		true if user.follows.any?
	end

	def receives_book_updates?(user)
		true if user.receive_book_updates
	end

end
