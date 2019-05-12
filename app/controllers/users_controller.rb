# the users controller here
# got an error
=begin 
 NameError:
   uninitialized constant UsersController::User
   This is due to the User model being missed  
=end
class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if(@user.save)
      render json: {
        msg: 'User got successfully registered but not verified', 
        status: 201
      }
    else
      render json: {
        msg: 'User not got created',
        status: 200
      }
    end
  end
  private
  def user_params
    params.require(:user).permit(:name,:mobile,:password)
  end
end
