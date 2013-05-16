require 'bcrypt'

include BCrypt

stef = User.new(name: "Stef", email: "thomas.stephn@gmail.com")
stef.password = "test"
p "Stef #{stef}"
stef.save