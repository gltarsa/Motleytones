class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id]) unless params[:id] == "sign_out"
  end

  def index
    @users = User.all
  end

  def new
    if user_signed_in?
      if current_user.admin?
        @user = User.new
      else
        flash[:alert] = "You must be an admin user to access that page"
        redirect_to current_user
      end
    else
      flash[:alert] = "You must be signed in to access that page"
      redirect_to root_path
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      total = current_user.class.all.count
      flash[:notice] = "New pirate added.  There #{(total == 1) ? "is" : "are"} now #{total} on the roster"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    if user_signed_in?
        if current_user.id.to_s == params[:id] || current_user.admin?
        @user = User.find(params[:id])
      else
        flash[:alert] = "You must be an admin user to access that page"
        redirect_to current_user
      end
    else
      flash[:alert] = "You must be signed in to access that page"
      redirect_to root_path
    end
  end

  def update
    @user = User.find(params[:id])

    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    if @user.update(user_params)
      redirect_to users_path
    else
      render 'edit'
    end

  end

  def destroy
    if current_user.id.to_s == params[:id]
      flash[:alert] = "You cannot delete your own account"
      redirect_to user_path
    else
      User.find(params[:id]).destroy
      total = User.all.count
      flash[:success] = "Pirate has been killed off, #{total} remain#{(total == 1)? "s" : ""}"
      redirect_to users_url
    end
  end

  protected

  def user_params
    if current_user.admin?
      params.require(:user).permit(:name, :email, :tone_name, :password, :password_confirmation, :admin)
    else
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :tone_name)
    end
  end
end
