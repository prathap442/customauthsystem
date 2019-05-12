require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  context 'users registrations' do   
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
    it 'the user object that exists in the create should have errros' do
      post :create,params: {user: {name: 'p1',mobile: '9972339927',password: ''}}
      expect(assigns[:user].errors.messages).to include(:password => 'can\'t be left blank')
    end
  end
end
