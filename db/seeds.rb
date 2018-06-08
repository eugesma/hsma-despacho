joeUser = User.new(
  :email                 => "joe@example.com",
  :password              => "12345678",
  :password_confirmation => "12345678"
)
joeUser.add_role :admin
joeUser.save!
User.create!( email: "jane@example.com", password: "12345678", password_confirmation: "12345678")
