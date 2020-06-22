class UsersController < ApplicationController
  def new
   @user = User.new
  end

  def show
   @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
     #handle a sucess save
     flash.now[:succes] = "Congrats you succesfully created a ChattboxKE account"
     log_in @user
     flash.now[:info] = "you are loggged in"
     redirect_to @user
      
    else
    flash.now[:warning] = "Your signup failed,try again"
    render 'new'
    end
end

 private
  
   def user_params
     params.require(:user).permit(:name,:email,:password,:password_confirmation)
   end
end
