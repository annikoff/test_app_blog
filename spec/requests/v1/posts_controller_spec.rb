# frozen_string_literal: true
require 'spec_helper'

# rubocop:disable Metrics/BlockLength
describe API::V1::PostsController do
  let(:user) { create(:user) }

  describe 'authenticate' do
    it 'rejects authentications' do
      user.password = 'test'
      get api_v1_posts_path, headers: http_authorization(user)
      expect(response).to have_http_status(401)
    end
  end

  describe 'index' do
    before { create_list(:post, 35, author: user) }

    it 'returns an array of posts' do
      get api_v1_posts_path, headers: http_authorization(user)

      expect(response).to have_http_status(200)
      json = parse_body(response)
      expect(json[:total_count]).to eq(35)
      expect(json[:pages]).to eq(1)
      expect(json[:posts].size).to eq(35)
    end

    it 'returns an array of posts with pagination' do
      get api_v1_posts_path(page: 2, per_page: 10),
          headers: http_authorization(user)

      expect(response).to have_http_status(200)
      json = parse_body(response)
      expect(json[:total_count]).to eq(35)
      expect(json[:pages]).to eq(4)
      expect(json[:posts].size).to eq(10)
    end
  end

  describe 'create' do
    it 'creates post with published_at' do
      params = {
        title: 'Test title',
        body: 'Test body',
        published_at: '2017-02-07 14:02'
      }
      post api_v1_posts_path(params), headers: http_authorization(user)

      expect(response).to have_http_status(200)
      expect(parse_body(response)).to eq(post_attributes(user.posts.last))
    end

    it 'fails when creates post with empty params' do
      post api_v1_posts_path({}), headers: http_authorization(user)

      expect(response).to have_http_status(422)
      errors = parse_body(response)[:errors]
      expect(errors.class).to eq(Array)
      expect(errors.first).to eq('Title can\'t be blank')
    end
  end

  describe 'update' do
    let(:post) { create(:post, author: user) }

    it 'updates post' do
      params = {
        title: 'New title',
        body: 'New body'
      }
      put api_v1_post_path(post, params), headers: http_authorization(user)

      expect(response).to have_http_status(200)
      json = parse_body(response)
      expect(json).to eq(post_attributes(user.posts.last))
      expect(json[:title]).to eq(params[:title])
      expect(json[:body]).to eq(params[:body])
    end

    it 'fails when updates post with wrong params' do
      params = { title: '' }
      put api_v1_post_path(post, params), headers: http_authorization(user)

      expect(response).to have_http_status(422)
      errors = parse_body(response)[:errors]
      expect(errors.class).to eq(Array)
      expect(errors.first).to eq('Title can\'t be blank')
    end
  end

  describe 'show' do
    let(:post) { create(:post, author: user) }

    it 'returns a post' do
      get api_v1_post_path(post), headers: http_authorization(user)
      expect(response).to have_http_status(200)
      expect(parse_body(response)).to eq(post_attributes(post))
    end

    it 'should return 404 response' do
      get api_v1_post_path(id: 999), headers: http_authorization(user)
      expect(response).to have_http_status(404)
    end
  end

  describe 'delete' do
    let(:post) { create(:post, author: user) }

    it 'returns a post' do
      delete api_v1_post_path(post), headers: http_authorization(user)
      expect(response).to have_http_status(200)
      expect(parse_body(response)).to eq({})
      expect(user.posts.size).to eq(0)
    end
  end
end
