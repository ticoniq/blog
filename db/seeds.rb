# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'

10.times do |i|
  user = User.create(
    name: Faker::Name.name,
    photo: "https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png",
    bio: Faker::Lorem.paragraphs(number: 4).join("\n\n"),
    posts_counter: rand(5..15) # Random post count for each user (between 5 and 15)
  )

  user.posts_counter.times do
    Post.create(
      author: user, # Assign the user as the author
      title: Faker::Lorem.sentence,
      text: Faker::Lorem.paragraphs(number: 4).join("\n\n"),
      likes_counter: rand(0..50),
      comments_counter: rand(0..20)
    )
  end

  30.times do
  Comment.create(
    user_id: User.order('RANDOM()').first.id, # Assign a random user as the commenter
    post_id: Post.order('RANDOM()').first.id, # Assign a random post as the commented post
    text: Faker::Lorem.sentence
  )
end
end