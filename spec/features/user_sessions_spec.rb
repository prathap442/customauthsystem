require 'rails_helper'
RSpec.describe 'Sessions specs',type: :request do
  context 'sessions related request specs' do
    it 'uses the sessions controller to get response for the signed in user' do
      get '/api/v1/users/sign_in'
      expect(response.content_type).to eq('application/json')
    end
    it 'asking for a new otp verfication' do
      post '/api/v1/users', params: {user: {name: 'p1', mobile: '9972339927', password: '123456'}}
      expect(response.content_type).to eq('application/json')
      response1 = JSON.parse(response.body)
      post '/api/v1/sessions/generate_new_otp',params: {user: {mobile: '9972339927'}}
      expect(response.content_type).to eq('application/json')
      response2 = JSON.parse(response.body)
    end

    it 'verfies the generated otp' do 
      post '/api/v1/users', params: {user: {name: 'p1', mobile: '9972339927', password: '123456'}}
      expect(response.content_type).to eq('application/json')
      response1 = JSON.parse(response.body)
      post '/api/v1/sessions/generate_new_otp',params: {user: {mobile: '9972339927'}}
      expect(response.content_type).to eq('application/json')
      response2 = JSON.parse(response.body)
      expect(response2['is_otp_generated']).to eq(true)
      expect(response2['otp']).not_to eq(nil)
      post '/api/v1/sessions/verify_otp',params: {user: {otp: response2['otp'], mobile: response2['mobile']}}
      expect(response.content_type).to eq('application/json')
      response3 = JSON.parse(response.body)
      expect(response3['x_auth_token']).not_to eq(nil)
    end
  end
end
