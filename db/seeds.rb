# db/seeds.rb

# Include the Faker gem
require 'faker'

# Create User records with fake data
10.times do
  User.create(
    name: Faker::Name.name,
    bio: Faker::Lorem.paragraph,
    photo: Faker::Avatar.image
  )
end

# Create some example posts
User.all.each do |user|
  3.times do
    user.posts.create(
      title: Faker::Lorem.sentence,
      text: Faker::Lorem.paragraph
    )
  end
end
