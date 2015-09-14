require 'rails_helper'

describe UsersController, type: :controller do
  before (:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end
end
