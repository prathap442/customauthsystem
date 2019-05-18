module Api
  module V1
    class SessionsController < ApplicationController
      before_action :find_user,only: [:generate_new_otp]
      def new
        @user = {
          user: {
            mobile: ''
          },
          msg: 'Utilize the user object format to dump in the required values in fields back to /api/v1/users/sign_in in post action'
        }
        render json: @user.to_json
      end

      # def create
      #   # things that i need to utilise here are the phone number
      #   # check whether the phone number exists and it is registered or not
      #   # if it is not give a message that u need to be registered else give back
      #   # the token that is related to him
      # end

      def generate_new_otp
        # things that i need to utilise here are the phone number
        # check whether the phone number exists and it is registered or not
        # if it is not give a message that u need to be registered else give back
        # the token that is related to him
        @user = User.find_by(generate_otp_params)
        if @user
          s1 = UserSessionService.new(@user)
          @response = s1.generate_otp
          render json: @response.to_json
        else
          render json: {
            msg: 'The submitted details are incorrect,you aren\'t registered user',
            is_otp_generated: false,
            otp: ''
          }.to_json
        end
      end

      def verify_otp
        @user = User.find_by(verifiy_otp_params)
        if(@user)
          otp_obtained = params[:user][:otp]
          response_obtained = UserSessionService.new(@user).verify_the_otp_obtained(otp_obtained)
          render json: response_obtained
        else
          render json: {
            msg: 'Mobile Invalid',
            is_x_auth_generated: false,
            x_auth_token: nil
          }
        end
      end

      private
      def generate_otp_params
        params.require(:user).permit(:mobile)
      end

      def verifiy_otp_params
        params.require(:user).permit(:mobile)
      end

      def find_user
        @user = User.find_by(find_user_params)
      end

      def find_user_params
        params.require(:user).permit(:mobile)
      end
    end
  end
end
