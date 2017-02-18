# frozen_string_literal: true
FactoryGirl.define do
  factory :post do
    sequence(:title) { |n| "title#{n}" }
    sequence(:body) { |n| "body#{n}" }
    association :author
  end
end
