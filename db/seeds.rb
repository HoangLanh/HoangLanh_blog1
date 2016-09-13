99.times do |n|
  name  = Faker::Name.name
  introduce = Faker::Lorem.sentence(50)
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
              email: email,
              role: 1,
              password:              password,
              password_confirmation: password)
end
users = User.order(:created_at).take(6)
50.times do
  title = Faker::Lorem.sentence(5)
  content = Faker::Lorem.sentence(50)
  users.each { |user| user.posts.create!(content: content, title: title) }
end
