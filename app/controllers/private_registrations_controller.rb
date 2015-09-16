class PrivateRegistrationsController < Devise::RegistrationsController
  skip_before_filter :require_no_authentication, only: [ :new, :create ]
  before_filter :authenticate_scope! #, only: [ :new, :edit, :update ]

  def new
    if user_signed_in?
      if current_user.admin?
        super
        total = current_user.class.all.count
        flash[:notice] = "New pirate added.  There #{(total == 1) ? "is" : "are"} now #{total} on the roster."
      else
        flash[:alert] = "You must be an admin user to access that page"
        redirect_to current_user
      end
    else
      flash[:alert] = "You must be signed in to access that page"
      redirect_to root_path
    end
  end

  protected

  # Overwriting sign_up so that we do not sign a user in upon sign up.
  def sign_up(resource_name, resource)
  end
end
