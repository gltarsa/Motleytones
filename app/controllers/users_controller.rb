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
      flash[:success] = "\"#{@user.name}\" added -- Welcome to the Motley Tones"
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end
end
