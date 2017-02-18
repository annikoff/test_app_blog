# frozen_string_literal: true
class Comment < ApplicationRecord
  validates :author, presence: true
  validates :body, presence: true
  belongs_to :author, class_name: User, foreign_key: :author_id
  belongs_to :post
end
