require 'rails_helper'

describe UsersController, type: :controller do
  before (:each) do
    @user = FactoryGirl.create(:user)
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "GET #index" do
    it "returns http success" do
      sign_in @user
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      sign_in @user
      get :show, id: @user.id
      expect(response).to have_http_status(:success)
    end
  end
end
