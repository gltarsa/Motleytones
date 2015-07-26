class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "User has been created"
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
    params.require(:user).permit(:name, :email, :admin)
  end
end
