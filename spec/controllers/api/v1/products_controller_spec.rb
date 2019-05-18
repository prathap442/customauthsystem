require 'rails_helper'

RSpec.describe 'products controller' do
  describe Api::V1::ProductsController, type: :controller do
    context 'when the params are invalid' do
      it 'gets the products for authorized users' do
        headers = {
          'x_auth_token' => '94082384934'
        }
        request.headers.merge! headers
        get :index, params: {}
        expect(response.content_type).to eq('application/json')
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['authentication']).to eq('failed')
      end
    end
    context 'when the params are valid' do
      it 'does get products for unauthorized users' do
      end
    end
  end
end