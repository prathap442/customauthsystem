class UserTokenAuthenticator
  def initialize(token='')
    @token = token 
  end

  def authenticate
    @secret = Rails.application.secrets[:secret_key_base]
    @payload = JWT.decode(@token,@secret,'HS256')
    if @payload.nil?
      return { authentication: 'failed', msg: 'Invalid token', products: [] }
    elsif @payload[0]['id'].to_i.positive?
      if find_user
        return after_checking_session_expiry
      else
        return {authentication: 'failed', msg: 'No such user exists', products: []}
      end
    else
      return {authentication: 'failed', msg: 'this is due to the user not exists', products: []}
    end
  rescue JWT::DecodeError
    { authentication: 'failed',msg: 'Invalid token',products: [] }
  end

  def find_user 
    @user = User.find_by(id: @payload[0]['id'].to_i)
  end

  def after_checking_session_expiry
    expiry_time_space = 1.hour.ago.to_time
    if @user.signed_in_at.to_time < 1.hour.ago.to_time
      { authentication: 'failed', msg: 'The Token got expired',products: []}
    else
      { authentication: 'passed', msg: 'JWT Token authenticated successfully',products: %w[a b c d]}
    end
  end
end
