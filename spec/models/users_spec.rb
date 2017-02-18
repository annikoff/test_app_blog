# frozen_string_literal: true
require 'rails_helper'

describe User do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:nickname) }
    it { is_expected.to validate_length_of(:nickname).is_at_most(30) }
    it { is_expected.to validate_uniqueness_of(:nickname).case_insensitive }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_length_of(:email).is_at_most(255) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to allow_value('test@example.com').for(:email) }
    it { is_expected.to_not allow_value('test@').for(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:posts).dependent(:destroy) }
  end
end
