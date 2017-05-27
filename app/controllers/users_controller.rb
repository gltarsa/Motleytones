# frozen_string_literal: true
class UsersController < Devise::RegistrationsController
  skip_before_action :require_no_authentication
  before_action :authenticate_scope!
  before_action :require_admin, only: [:new, :create, :destroy]
  before_action only: [:update], unless: -> { myself_or_admin } do
    require_admin(redirect_path: users_path)
  end
  before_action :set_user, only: [:show, :edit, :update, :destroy]

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
    require_admin(redirect_path: users_path) unless myself_or_admin
  end

  def update
    remove_unused_password_pair_from_params

    if @user.update(allowed_user_params)
      bypass_sign_in(@user) if @user == current_user
      set_flash_message :notice, :pirate_updated
      return redirect_to users_path
    end

    set_flash_message :alert, :pirate_update_failed
    render :edit
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

  def myself_or_admin
    current_user.id.to_s == params[:id] || current_user.admin?
  end

  def allowed_user_params
    allowed = %i(name email password password_confirmation tone_name band_start_date)
    allowed << :admin if current_user.admin?
    params.require(:user).permit(*allowed)
  end

  def remove_unused_password_pair_from_params
    return if params[:user][:password].present?
    delete_password_related_keys
  end

  def delete_password_related_keys
    params[:user].delete(:password)
    params[:user].delete(:password_confirmation)
  end


  def require_admin(redirect_path: root_path)
    return if current_user.admin?
    set_flash_message :alert, :must_be_admin
    redirect_to redirect_path
  end
end
