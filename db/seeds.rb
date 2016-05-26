# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
ActiveRecord::Base.transaction do

a_long_url = 'https://github.com/appacademy/curriculum/tree/master/sql/projects/url_shortener'
b_long_url = 'http://progress.appacademy.io/me'

User.create(email: 'a@email.com')
User.create(email: 'b@email.com')

ShortenedUrl.create(long_url: a_long_url, user_id: 1)
ShortenedUrl.create(long_url: b_long_url, user_id: 2)

Visit.create(user_id: 2, shortened_url_id: 1)

end
