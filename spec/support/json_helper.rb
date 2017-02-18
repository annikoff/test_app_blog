# frozen_string_literal: true
module JsonHelper
  def parse_body(response)
    body = JSON.parse(response.body)
    return body.map(&:symbolize_keys) if body.is_a? Array
    body.symbolize_keys
  end

  def post_attributes(post)
    {
      id: post.id,
      title: post.title,
      body: post.body,
      published_at: post.published_at.as_json,
      author_nickname: post.author_nickname
    }
  end
end
