class UsersController < Devise::RegistrationsController
  skip_before_action :require_no_authentication
  before_action :authenticate_scope!
  before_action :require_admin, only: [ :new, :create, :destroy ]
  before_action :set_user,      only: [ :show, :update, :destroy ]

  def show
  end

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(allowed_user_params)
    if @user.save
      set_flash_message :notice, :new_pirate_added, count: User.count
      redirect_to @user
    else
      render :new
    end
  end

  def edit
    if current_user.id.to_s == params[:id] || current_user.admin?
      set_user
    else
      set_flash_message :alert, :must_be_admin
      redirect_to current_user
    end
  end

  def update
    remove_unused_password_pair_from_params

    if @user.update(allowed_user_params)
      redirect_to users_path
    else
      render :edit
    end
  end

  def destroy
    if current_user.id.to_s == params[:id]
      set_flash_message :alert, :cannot_delete_own_account
    else
      @user.destroy
      set_flash_message :notice, :pirate_deleted, count: User.count
    end

    redirect_to users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def allowed_user_params
    if current_user.admin?
      params.require(:user).permit(:name, :email, :tone_name, :password, :password_confirmation, :band_start_date, :admin)
    else
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :tone_name, :band_start_date)
    end
  end

  def remove_unused_password_pair_from_params
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
  end

  def require_admin
    unless current_user.admin?
      set_flash_message :alert, :must_be_admin
      redirect_to root_path
    end
  end
end
