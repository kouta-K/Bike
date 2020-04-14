User.create!(name:  "Example User",
             email: "Test@co.jp",
             age: 18,
             password:              "password",
             password_confirmation: "password",
             activated: true,
             activated_at: Time.zone.now)
User.create!(name: "koutakoutakoutakoutakoutakouta",
            email: "Test3@co.jp",
            age: 20,
            password: "password",
            password_confirmation: "password",
            activated: true,
            activated_at: Time.zone.now
            )

User.create!(name:  "Example User2",
             email: "Test2@co.jp",
             age: 18,
             password:              "password",
             password_confirmation: "password",
             activated: true,
             activated_at: Time.zone.now)
             
User.create!(name:  "Example User4",
             email: "Test4@co.jp",
             age: 21,
             password:              "password",
             password_confirmation: "password",
             activated: true,
             activated_at: Time.zone.now)
             
30.times do |i|
    User.create!(name:  Faker::Name.name,
             email: "Test#{i+5}@co.jp",
             age: 18+i,
             password:              "password",
             password_confirmation: "password",
             activated: true,
             activated_at: Time.zone.now)
end

users = User.order(:created_at).take(3)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end

