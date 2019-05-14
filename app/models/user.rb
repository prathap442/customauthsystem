class User < ApplicationRecord
  has_secure_password
  validates :name, :mobile, :password_digest, presence: true
  validates :mobile, uniqueness: true

  # bcrypt provides us with a method called .authenticate which is used to verify 
  # the customers during login
end
