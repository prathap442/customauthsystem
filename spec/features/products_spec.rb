require 'rails_helper'
RSpec.describe 'product spec',type: :request do
  it 'product specs gives back the products' do 
    
  end
  context 'when the params are correct' do 
    before(:example) do
      @user = FactoryBot.create(:user)
      post '/api/v1/sessions/generate_new_otp', params: { user: { mobile: @user.mobile } }
      @parsed_response_one = JSON.parse(response.body)
    end
    it 'gives the products array whoes length is greater than one' do 
      post '/api/v1/sessions/verify_otp', params:
      {
        user:
          {
            mobile: @user.mobile,
            otp: @parsed_response_one['otp']
          }
      }
      parsed_response2 = JSON.parse(response.body)
      expect(parsed_response2['x_auth_token']).not_to eq(nil)
      expect(parsed_response2['is_x_auth_generated']).to eq(true)
      headers = {
          'x_auth_token' => parsed_response2['x_auth_token']
      }
      request.headers['x_auth_token'] = parsed_response2['x_auth_token']
      get '/api/v1/products',params: {}, headers: {'ACCEPT' => 'application/json','x_auth_token'=> parsed_response2['x_auth_token']}
      parsed_response_1 = JSON.parse(response.body)
      expect(parsed_response_1['products'].count).to be_positive
    end
  end

end