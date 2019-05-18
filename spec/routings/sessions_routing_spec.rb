# frozen_string_literal: true
# this describe all the routings of the sessions
require 'rails_helper'

RSpec.describe 'sessions routing specs',type: :routing do
  it 'sessions#new' do
    expect(get('/api/v1/users/sign_in')).to route_to('api/v1/sessions#new')
  end

  it 'sessions#generateotp' do
    expect(
      post('/api/v1/sessions/generate_new_otp')
    ).to route_to('api/v1/sessions#generate_new_otp')
  end

  it 'sessions#verifyotp' do
    expect(
      post('/api/v1/sessions/verify_otp')
    ).to route_to('api/v1/sessions#verify_otp')
  end
end
