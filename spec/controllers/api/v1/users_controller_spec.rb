require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  context 'users registrations users#create' do
    context 'when the params are valid' do
      before(:example){ post :create, params: {user: {name: 'p1',mobile: '9972339927',password: '123456'} } }
      it 'successfully creates the user' do
        expect(JSON.parse(response.body)).to include({'msg' => 'User got successfully registered but not verified'})
      end
      it 'expects the status code 201 created' do
        expect(response.status).to eq(201)
      end
      it 'expects the user to be an instance of the User' do 
        expect(assigns[:user]).to be_instance_of(User)
      end
    end
  end
  context 'when the params are invalid' do
    # first make the spec to fail
    # expected {} to include {:password => "can't be left blank"}
    it 'the user instance should have errors when the params are invalid' do
      params = {user: { name: 'p1', mobile: '9972339927', password: '' } }
      post :create, params: params
      expect(assigns[:user].errors.messages).to include(:password => ['can\'t be blank'])
    end
    it 'the response obtained sohould have json content' do
      params = { user: { name: 'p1', mobile: '9972339927', password: '' } }
      post :create, params: params
      expect(response.content_type).to eq('application/json')
    end
  end
end
