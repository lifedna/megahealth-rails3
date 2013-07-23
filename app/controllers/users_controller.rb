class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update_attributes(params[:user])
      flash[:success] = "User updated successfully!"
      sign_in @user
      redirect_to account_url
    end
  end

  def update_password
    @user = User.find(current_user.id)

    if @user.update_with_password(params[:user])
      flash[:success] = "Your Password has been updated!"
      sign_in @user, :bypass => true
    else
      flash[:alert] = @user.errors.full_messages.join("<br />")
    end  
    redirect_to account_url
  end
end
