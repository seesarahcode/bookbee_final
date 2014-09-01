scheduler = Rufus::Scheduler.new



scheduler.every("24h") do

	User.all.each do |u|
		if u.email_frequency == :daily
			if DailyDigestEvents.where(:user_id => u.id)
	   		if DailyDigestEvents.where("created_at >= ?", Time.zone.now.beginning_of_day)	
	   			DailyDigest.send_daily_digest(u).deliver
	   		end
	   	end
   	end
  end

end 