# frozen_string_literal: true
class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, length: { maximum: 255 },
                    format: {
                      with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
                    }, uniqueness: { case_sensitive: false }
  validates :nickname, presence: true, length: { maximum: 30 },
                       uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  before_save { self.email = email&.downcase }
  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :comments, foreign_key: :author_id, dependent: :destroy
end
