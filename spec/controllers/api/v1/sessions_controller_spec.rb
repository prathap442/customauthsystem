require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do
  describe 'sessions#new' do
    context 'during the request of the new session' do
      before(:example) { get :new }
      it 'gets the json data when there is a new request' do
        expect(response.content_type).to eq('application/json')
      end
      it 'checks whether assigned object meets the requirement' do
        expect(JSON.parse(response.body)).to include(
          'user' => {
            'mobile' => ''
          }
        )
      end
    end
  end
  describe 'sessions#generate_new_otp' do
    context 'when the params are correct' do
      it 'generates a new otp for a user with session created' do
        user = FactoryBot.create(:user)
        post :generate_new_otp, params: {user: {mobile: user.mobile} }
        expect(response.content_type).to eq('application/json')
        response1 = JSON.parse(response.body)
        expect(assigns[:user]).to eq(user)
        expect(response1["is_otp_generated"]).to eq(true)
      end
    end
    context 'when the params are incorrect' do 
      it 'doesn\'t generate the otp' do 
        user = FactoryBot.create(:user)
        post :generate_new_otp, params: {user: {mobile: '8329'}}
        expect(response.content_type).to eq('application/json')
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['is_otp_generated']).to eq(false)
      end
    end
  end

  describe 'sessions_controller#verify_the_otp' do 
    context 'when the params are valid' do
      it 'verfies the otp here' do 
        user = FactoryBot.create(:user)
        post :generate_new_otp, params: { user: { mobile: user.mobile } }
        parsed_response = JSON.parse(response.body)
        post :verify_otp, params:
        {
          user:
            {
              mobile: user.mobile,
              otp: parsed_response['otp']
            }
        }
        parsed_response2 = JSON.parse(response.body)
        expect(parsed_response2['x_auth_token']).not_to eq(nil)
        expect(parsed_response2['is_x_auth_generated']).to eq(true)
      end
    end
    context 'when the params are invalid during verify otp' do
      before(:example) do
        @user = FactoryBot.create(:user)
        post :generate_new_otp, params: { user: { mobile: @user.mobile } }
        @parsed_response_one = JSON.parse(response.body)
      end
      it 'when the otp is given is invalid' do
        post :verify_otp, params:
        {
          user:
            {
              mobile: @user.mobile,
              otp: @parsed_response_one['otp']+'123'
            }
        }
        parsed_response2 = JSON.parse(response.body)
        expect(parsed_response2['x_auth_token']).to eq(nil)
        expect(parsed_response2['is_x_auth_generated']).to eq(false)
      end
      it 'when the otp is valid and the phone is invalid' do
        post :verify_otp, params:
        {
          user:
            {
              mobile: @user.mobile+'123',
              otp: @parsed_response_one['otp']
            }
        }
        parsed_response2 = JSON.parse(response.body)
        expect(parsed_response2['x_auth_token']).to eq(nil)
        expect(parsed_response2['is_x_auth_generated']).to eq(false)
        expect(parsed_response2['msg']).to eq('Mobile Invalid')
      end
    end
  end
end
