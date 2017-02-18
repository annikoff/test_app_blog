# frozen_string_literal: true
FactoryGirl.define do
  factory :user do
    sequence(:nickname) { |n| "user#{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password '123456'
  end
end
