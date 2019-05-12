# the users controller here got to do operations of create
class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if (@user.save)
      render json: {
        msg: 'User got successfully registered but not verified'
      },status: 201
    else
      render json: {
        msg: 'User not got created'
      },status: 200
    end
  end
  private
  def user_params
    params.require(:user).permit(:name,:mobile,:password)
  end
end
