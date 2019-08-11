class User < ApplicationRecord
  attr_accessor :password_reset_token

  before_save { self.email = email.downcase }
  before_create { self.username = email.split('@').first.downcase }
  validates :username, presence: true, length: {minimum: 5, maximum: 255}, on: :update
  validates :email, presence: true, length: {maximum: 255},
            format: {with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i},
            uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 8}, allow_nil: true

  has_secure_password

  # Sets the password reset attributes
  def create_reset_digest
    self.password_reset_token = User.token
    update_attribute(:password_reset_digest, User.digest(password_reset_token))
    update_attribute(:password_reset_sent_at, Time.zone.now)

    # Sends password reset email to the user
    UserMailer.password_reset(self).deliver_now
  end

  # Check if password reset request has been expired
  def is_password_reset_expired?
    password_reset_sent_at < 6.hours.ago
  end

  class << self
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def token
      SecureRandom.urlsafe_base64
    end
  end
end