 require 'faker'
 
 # Create Posts
 50.times do
   Post.create!(
     title:  Faker::Lorem.sentence,
     body:   Faker::Lorem.paragraph
   )
 end
 posts = Post.all
 
 # Create Comments
 100.times do
   Comment.create!(
     post: posts.sample,
     body: Faker::Lorem.paragraph
   )
 end
 
 post = Post.where(title: "Unique").first
 if post.nil?
    Post.create!(
    title: "Unique",
    body: "I'm a body!"
    )
 end
 
 # Create Advertisements
 100.times do
   Advertisement.create!(
     title:  Faker::Lorem.sentence,
     copy:   Faker::Lorem.paragraph,
     price:  Faker::Number.number(3)
   )
 end


 puts "Seed finished"
 puts "#{Post.count} posts created"
 puts "#{Comment.count} comments created"