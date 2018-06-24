joeUser = User.new(
  :username              => "eugesma",
  :password              => "12345678",
  :password_confirmation => "12345678"
)
joeUser.add_role :admin
joeUser.save!
User.create!( username: "damian", password: "12345678", password_confirmation: "12345678")
