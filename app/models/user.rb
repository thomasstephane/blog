require 'bcrypt'

class User < ActiveRecord::Base
  has_many :posts
  validates :name, uniqueness: true

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end


  def self.login(name, pass)
    user = User.find_by_name(name)
    if user.nil?
      false
    else
      user.password == pass
    end
  end
end

