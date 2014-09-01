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

	def blocked_user?(user)
		true if user.blocked_users.find_by_user_id(user.id)
	end

	def following?(user, book)
		user.follows.where(book_id = book.id).exists?
	end

	def set_tags(book)
    book.tags.each do |t|
      tag_word = t.name.to_s
      TagWord.new(:tag_word => "#{tag_word}", :book_id => book.id)
    end
  end

end
