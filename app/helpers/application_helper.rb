module ApplicationHelper

	def full_title(page_title)
    base_title = "Bookbee"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def current_user=(user)
		@current_user = user
	end

	def current_user
		remember_token = User.digest(cookies[:remember_token])
		@current_user ||= User.find_by(remember_token: remember_token)
	end

	def current_user?(user)
		user == current_user
	end

	def admin?(user)
		user.admin == true
	end

	def following?(user, book)
		user.follows.where(book_id = book.id).exists?
	end

# Returns BCC list
	def rating_email_list(book)
		# email list to return at the end
		@bcc = []
		# search through every user and find
		User.all.each do |u|
			# if User has a Follow that matches this book
			if following?(u, book)
			# and follow's rating is set to true
				Follow.all.each do |f|
					if f.ratings == true
						# add to bcc
						bcc << u.email
					end
				end
			end
		end
		return @bcc
	end

# Returns BCC list
	def review_email_list(book)
		# email list to return at the end
		@bcc = []
		# search through every user and find
		User.all.each do |u|
			# if User has a Follow that matches this book
			if following?(u, book)
			# and follow's rating is set to true
				Follow.all.each do |f|
					if f.reviews == true
						# add to bcc
						bcc << u.email
					end
				end
			end
		end
		return @bcc
	end

end
