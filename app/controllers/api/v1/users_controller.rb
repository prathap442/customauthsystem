# the users controller here got to do operations of create
class Api::V1::UsersController < ApplicationController
  def create 
    # this is for the registrations create action
    @user = User.new(user_params)
    if @user.save
      @user.is_registered = true
      render json: {
        msg: 'User got successfully registered but not verified'
      }, status: 201
    else
      @user.is_registered = false
      render json: {
        msg: 'User not got created'
      }, status: 200
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,:mobile,:password)
  end
end
