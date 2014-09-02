module UsersHelper

	def gravatar_for(user)
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
		image_tag(gravatar_url, alt: user.name, class: "gravatar")
	end

	def follows_exist?(user)
		if user.follows.any?
			true
		else
			false
		end
	end

	def receives_book_updates?(user)
		if user.receive_book_updates
			true
		else
			false
		end
	end

end
