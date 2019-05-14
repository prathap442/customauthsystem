# these are for routing specs
# frozen_string_literal: true
require 'rails_helper'
RSpec.describe 'Users routings',type: :routing do
  it 'routes the request for post to users#create' do
    expect(post('/api/v1/users')).to route_to('api/v1/users#create')
  end
end
