class UsersController < ApplicationController
  
before_action :logged_in_user,only: [:edit,:update,:update]
before_action :correct_user,only: [:edit,:update]
before_action :admin_user,only: :destroy
  def new
   @user = User.new
  end
  
  def index
  @users = User.paginate(page: params[:page])
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

  def edit
    @user = User.find(params[:id])
  end

 def update
   @user = User.find(params[:id])
   if @user.update(user_params)
   #handle successful update
     flash.now[:success] = "Profile updated successfully"
     redirect_to @user
   else
    flash.now["try again"]
    render 'edit'
    end
  end

 def logged_in_user
   unless logged_in?
   store_location
   flash[:danger] = "Please log in"
   redirect_to login_url
   end
 end

 
 def correct_user
   @user = User.find(params[:id])
   redirect_to(root_url) unless current_user?(@user)
   end
  
 def destroy
   User.find(params[:id]).destroy
   flash.now[:success] = "deleted"
   redirect_to users_url
   end
 
 def admin_user
   redirect_to(root_url) unless current_user.admin?
  end
   
 private
  
   def user_params
     params.require(:user).permit(:name,:email,:password,:password_confirmation)
   end
end
