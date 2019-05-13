class User < ApplicationRecord
  validates :name, :mobile, :password, presence: true
  validates :mobile, uniqueness: true
end
