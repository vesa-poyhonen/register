class User < ApplicationRecord
  before_save { self.email = email.downcase }
  before_create { self.username = email.split('@').first.downcase }
  validates :username, presence: true, length: {minimum: 5, maximum: 255}, on: :update
  validates :email, presence: true, length: {maximum: 255},
            format: {with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i},
            uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 8}, allow_nil: true

  has_secure_password
end