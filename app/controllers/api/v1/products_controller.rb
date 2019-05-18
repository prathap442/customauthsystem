class Api::V1::ProductsController < ApplicationController
  def index
    sanitize_the_x_auth_headers
    response = UserTokenAuthenticator.new(@token).authenticate
    render json: response.to_json
  end

  def products_generator
    %w[a b c d]
  end

  def sanitize_the_x_auth_headers
    @token = request.headers['x_auth_token']
  end
end
