# frozen_string_literal: true
class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :published_at, :author_nickname
end
