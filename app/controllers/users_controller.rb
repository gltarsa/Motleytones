class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "#{@user.name} added -- Welcome to the Motley Tones"
      # this is trying to go to a list of users, do we want to go to a display of the newly created user?
      redirect_to users_path
    else
      render :new
    end
  end

  private

  def user_params
    # we must have "user" in the params hash.  Only those fields in the permitted
    # list will be allowed into the app from the view.
    params.require(:user).permit(:name, :email, :tone_name, :password, :password_confirmation, :admin)
  end
end
