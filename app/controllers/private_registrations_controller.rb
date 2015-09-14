class PrivateRegistrationsController < Devise::RegistrationsController
  skip_before_filter :require_no_authentication, only: [ :new, :create ]
  before_filter :authenticate_scope! #, only: [ :new, :edit, :update ]

  def new
    if user_signed_in?
      if current_user.admin?
        super
        flash[:notice] = "New pirate added.  There are now #{(current_user.class).all.count} on the roster."
      else
        flash[:alert] = "You must be an admin user to access that page"
        redirect_to current_user
      end
    else
      flash[:alert] = "You must be signed in to access that page"
      redirect_to root_path
    end
  end

  def edit
    def resource
      if params[:id].blank?
        current_user
      else
        User.find(params[:id])
      end
    end
    puts "------------------------ edit resource: #{resource.id}: #{resource.name} (#{resource.tone_name})"
    puts "#{params}"
    # binding.pry
    super
  end

  def update
    def resource
      if params[:id].blank?
        current_user
      else
        User.find(params[:id])
      end
    end
    puts "======================== update resource: #{resource.id}: #{resource.name} (#{resource.tone_name})"
    puts "#{params}"
    # binding.pry
    super
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Pirate has been killed off, #{User.all.count} remain."
    redirect_to users_url
  end

  protected

  # Overwriting sign_up so that we do not sign a user in upon sign up.
  def sign_up(resource_name, resource)
  end
end
