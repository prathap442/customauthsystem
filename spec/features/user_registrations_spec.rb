require 'rails_helper'

RSpec.describe '/users',type: :request do 
  let(:params) do
    {user: {name: 'p1',mobile: '9972339927',password: '1234567'}} 
  end
  context 'when the params are correct' do 
    it 'posts the user data' do  
      post '/users',params: params
    end
  end
end