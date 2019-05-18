# frozen_string_literal: true
# This is the services module for user sessions
class UserSessionService
  attr_accessor :user

  def initialize(user)
    @user = user
    raise if @user.class != User
  end

  def generate_otp
    if(@user.is_verified == false)
      payload = {
        id: @user.id
      }
      # secret = Rails.application.master
      # encoded_token = JWT.encode(payload,secret,'HS256')
      # @user.session_token = encoded_token
      @time = Time.now
      @user.otp_sent = generate_a_random_token_of_alpha_numeric
      @user.otp_generated_at = @time
      if(@user.save)
        return {
          msg: 'User\'s otp is successfully being generated with otp',
          otp: @user.otp_sent,
          is_otp_generated: true,
          mobile: @user.mobile
        }
      else
        return {
          msg: "User\'s otp is not generated due to #{@user.errors}",
          otp: '',
          is_otp_generated: false,
          mobile: @user.mobile
        }
      end
    end
  end

  def verify_the_otp_obtained(new_otp)
    if(@user.otp_generated_at < 1.minute.ago.to_time)
      render json: {msg: 'otp expired,regenerate it',is_x_auth_generated: false}
    elsif(@user.otp_generated_at >= 1.minute.ago.to_time)
      if(@user.otp_sent == new_otp)
        x_auth_token = generate_x_auth_token
        current_time = Time.now
        previous_time = @user.signed_in_at
        if !(@user.last_signed_in_at)
          @user.update_attributes(
              is_verified: true,
              last_signed_in_at: current_time,
              signed_in_at: current_time,
              session_token: x_auth_token
            )
        else
          @user.update_attributes(is_verified: true,session_token: x_auth_token,signed_in_at: current_time,last_signed_in: previous_time)
        end
        return {
          x_auth_token: @user.session_token,
          msg: 'successfully generated x-auth-token',
          is_x_auth_generated: true
        }.to_json
      else
        return {
          x_auth_token: nil,
          msg: 'Otp Invalid!',
          is_x_auth_generated: false 
        }
      end
    end
  end

  def token_is_valid
    custom_timing = 1.minute.ago
    if @user.otp_generated_at < custom_timing
      return false
    else
      return true
    end
  end

  def check_the_authenticity
    if !(@user.is_verified)
      otp_generated = generate_a_random_token_of_alpha_numeric
      @user.otp_sent = otp_generated
      @user.is_verified = false
    else

    end  
  end

  private 
  
  def generate_a_random_token_of_alpha_numeric
    number_of_digits = 6
    a = [(0..9), ('a'..'z')].map{|x| x.to_a}
    a.flatten.sample(number_of_digits).join('')
  end

  def generate_x_auth_token
    payload = {
      id: @user.id
    }
    secret = Rails.application.secrets[:secret_key_base]
    encoded_token = JWT.encode(payload,secret,'HS256')
  end

end