class Spinach::Features::AdminUserManagement < Spinach::FeatureSteps
  include Helpers

  step "I am signed in as an admin user" do
    sign_in_admin_user
  end
end
