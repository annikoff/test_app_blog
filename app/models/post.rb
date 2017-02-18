# frozen_string_literal: true
class Post < ApplicationRecord
  validates :author, presence: true
  validates :title, presence: true, length: { maximum: 255 }
  before_save -> { self.published_at ||= Time.current }, on: :create
  belongs_to :author, class_name: User, foreign_key: :author_id
  has_many :comments, dependent: :destroy
  delegate :nickname, to: :author, prefix: :author
end
