# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# 20.times do
#   User.create(email: Faker::Internet.email(domain: 'test.com'),
#               password: 'password',
#               first_name: Faker::Name.first_name,
#               last_name: Faker::Name.last_name)
#               completed_registration: true
# end

# User.all.each do |user|
#   SiteUser.create(site_id: 89,
#                   user_id: user.id)
# end
