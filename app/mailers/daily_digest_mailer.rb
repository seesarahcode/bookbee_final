class DailyDigestMailer < ActionMailer::Base
  default from: "daily@example.com"

  def send_daily_digest(user)
  	@user = user
  	all_events = DailyDigestEvents.where(:user_id => user.id)
  	todays_events = all_events.where("created_at >= ?", Time.zone.now.beginning_of_day)
  	@review_events = todays_events.where(:update_type => :review)
  	@rating_events = todays_events.where(:update_type => :rating)
  	mail(to: @user.email, subject: "The Bookbee Daily Digest has arrived!")
  end

end
