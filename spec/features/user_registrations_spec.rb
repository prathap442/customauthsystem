require 'rails_helper'

RSpec.describe 'api/v1/users',type: :request do 
  let(:params) do
    {user: {name: 'p1',mobile: '9972339927',password: '1234567'}} 
  end
  context 'when the params are correct' do 
    it 'posts the user data' do
      post '/api/v1/users',params: params
      expect(response).to have_http_status(:created)
    end
    it 'render the content of the type json' do
      post '/api/v1/users',params: params
      expect(response.content_type).to eq('application/json')
    end
  end
end