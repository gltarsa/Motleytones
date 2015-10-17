require 'rails_helper'

describe UsersController, type: :controller do
  before (:each) do
    @user = FactoryGirl.create(:user)
    @admin_user = FactoryGirl.create(:admin)
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "GET #index" do
    it "responds with http success" do
      sign_in @user
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "responds with http success" do
      sign_in @user
      get :show, id: @user.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    context "when called as a non-admin user" do
      it "responds with http redirect" do
        sign_in @user
        get :new
        expect(response).to have_http_status(:redirect)
      end
    end

    context "when called as an admin user" do
      it "responds with success" do
        sign_in @admin_user
        get :new
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "GET #create" do
    context "when called as a non-admin user" do
      it "responds with http redirect and creates no user" do
        starting_user_count = User.count
        sign_in @user
        get :create
        ending_user_count = User.count
        expect(response).to have_http_status(:redirect)
        expect(ending_user_count).to eql(starting_user_count)
      end
    end

    context "when called as an admin user" do
      it "responds with http redirect and creates a user" do
        new_user = FactoryGirl.attributes_for(:user)
        starting_user_count = User.count
        sign_in @admin_user
        get :create, user: new_user
        ending_user_count = User.count
        expect(response).to have_http_status(:redirect)
        expect(ending_user_count).to eql(starting_user_count + 1)
      end
    end
  end

  describe "DELETE #destroy" do
    context "when called as a non-admin user" do
      it "responds with http redirect and does not delete anything" do
        starting_user_count = User.count
        sign_in @user
        delete :destroy, id: @user.id
        ending_user_count = User.count
        expect(response).to have_http_status(:redirect)
        expect(ending_user_count).to eql(starting_user_count)
      end
    end

    context "when called as an admin user" do
      it "responds with http redirect and deletes the specified user" do
        starting_user_count = User.count
        sign_in @admin_user
        delete :destroy, id: @user.id
        ending_user_count = User.count
        expect(response).to have_http_status(:redirect)
        expect(ending_user_count).to eql(starting_user_count - 1)
      end

      it "responds with http redirect and does not delete itself" do
        starting_user_count = User.count
        sign_in @admin_user
        delete :destroy, id: @admin_user.id
        ending_user_count = User.count
        expect(ending_user_count).to eql(starting_user_count)

      end
    end
  end
end
