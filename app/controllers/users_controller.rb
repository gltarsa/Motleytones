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
      flash[:notice] = "User has been created"
      # this is trying to go to a list of users, do we want to go to a display of the newly created user?
      redirect_to users_path
    else
      puts "--------------- user not saved -----------------------"
      puts "#{@user.errors.inspect}"
      puts "--------------- user not saved -----------------------"
      render :new
    end
  end

  private

  def user_params
    # we must have "user" in the params hash and we will only accept the permitted parameters
    params.require(:user).permit(:name, :email, :admin)
  end
end
