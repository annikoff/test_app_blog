# frozen_string_literal: true
require 'rails_helper'

describe Post do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:author) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_most(255) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:author) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
  end

  describe 'creation' do
    let(:user) { create(:user) }

    it 'sets current time to published_at' do
      time_now = Time.current

      Timecop.freeze(time_now) do
        post = Post.create(title: 'Title', author: user)
        expect(post.new_record?).to eq(false)
        expect(post.published_at).to eq(time_now)
      end
    end
  end
end
