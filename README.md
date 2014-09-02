[![Code Climate](https://codeclimate.com/github/sarahwheeler/bookbee_final/badges/gpa.svg)](https://codeclimate.com/github/sarahwheeler/bookbee_final)

[![Build Status](https://travis-ci.org/sarahwheeler/bookbee_final.svg?branch=master)](https://travis-ci.org/sarahwheeler/bookbee_final)




#Bookbee
A library management app.

## Set up

Navigate to where you'd like to save the app in terminal, and:

	git clone https://github.com/sarahwheeler/bookbee_final.git

	bundle install

That's it!

#### To Set Up Admin:

Go to app in terminal:

	rails c

	new_admin = User.new(:name => "You", :email => "you@you.com", :password=>"password", :password_confirmation => "password", :admin => true)

	new_admin.save!


###Currently passing these requirements (20.5-ish/20):

1.  Anyone can see all the book titles and ratings in the library
2.  You must login to add library books
3.  Admin must approve the addition of lib books
4.  You must be logged in to rate a book
5.  To rate a book you must click on stars
6.  You can give a book 1-5 stars
7.  You can add a review to any book
8.  You can only edit/destroy books you entered into the system
9.  If a book has ratings or reviews, you can not destroy it, only deactivate it
10. Deactivated books can not get new reviews or ratings
11. Users can receive emails when their books get rated or reviewed
12. Users can "follow" books - which means they get email notifications on ratings and reviews
13. Users can opt out of all or by book rating emails 
14. Users can opt out of all or by book review emails 
15. Users can configure their email preferences
16. Users can ask to receive a daily digest of email notifications instead of individual notifications
17. Books must have a picture associated with them to be approved
18. Admins can block users from creating ratings or reviews in the system
19. Books should be searchable by title, author, ISBN, tags, ratings, and reviews
21. Book listings are paginated (but no sorting or pagination for ratings)
22. Admins can invite other admins (but not create)
23. Users can invite other users

### And also these requirements:

1.  80% of the above items implemented (20.5/25)
		Done!

2.  Code Climate grades = your grade on the project (need a 3.0 or better to pass)
		Done!

3.  100% code test coverage via Simple Cov 
		Pretty much (87.12%)

4.  Github repo linked to Pivotal Tracker
		Done!

5.  Pivotal Tracker project to track requirements, and development tasks from above list and any additional things you realize you need to do (each commit message must be linked to a PT ticket)
		Done! See PivotalTracker here: https://www.pivotaltracker.com/n/projects/1132470

6.  ReadMe with setup instructions for your app and CodeClimate Badge
		Done! See this.

7.  Should not be ugly (twitter-bootstrap, Zurb foundation, or your own styles applied is fine, but something nicer than default rails stuff.)
		Very basic, but done!

