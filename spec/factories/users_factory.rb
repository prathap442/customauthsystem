# frozen_string_literal: true
FactoryBot.define do
  # this for the new session which requires the fields of phone number
  factory :user,class: User do
    name { 'p1' }
    mobile { '9972339927' }
    password { '123456' }
  end
end
