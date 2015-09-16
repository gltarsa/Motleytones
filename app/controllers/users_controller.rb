class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
    puts "------------------------ edit user: #{@user.id}: #{@user.name} (#{@user.tone_name})"
    puts "#{params}"
  end

  def update
    @user = User.find(params[:id])

    puts "======================== update resource: #{@user.id}: #{@user.name} (#{@user.tone_name})"
    puts "#{params}"
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
      puts "Filtered params: #{params}"
    end
    if @user.update(user_params)
      redirect_to users_path
    else
      puts "#{@user.errors.inspect}"
      redirect_to edit_user_path
    end

  end

  def destroy
    User.find(params[:id]).destroy
    total = User.all.count
    flash[:success] = "Pirate has been killed off, #{total} remain#{(total == 1)? "s" : ""}."
    redirect_to users_url
  end

  protected

  def user_params
    if current_user.admin?
      tmp = params.require(:user).permit(:name, :email, :tone_name, :admin)
    else
      tmp = params.require(:user).permit(:name, :email, :tone_name)
    end
    puts "======================== sanitized params"
    puts "#{tmp}"
    tmp
  end
end
