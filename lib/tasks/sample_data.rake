namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Example User",
                 email: "example@email.com",
                 password: "foobar",
                 password_confirmation: "foobar")
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@email.com"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end

# namespace :db do
#   desc "Fill database with sample data"
#   task populate: :environment do
#     Book.create!(title: "Harry Potter and Goblet of Fire",
#                  author: "J.K. Rowling",
#                  isbn: "0-7475-4624-X"
#     30.times do |n|
#       title  = Faker::Name.title
#       author = "J.K. Rowling"
#       isbn  = "0-7475-4624-X"
#       Book.create!(title: title,
#                    author: author,
#                    isbn: isbn,
#     end
#   end
# end
# RUN: 
# rake db:reset
# $ bundle exec rake db:populate
# $ bundle exec rake test:prepare