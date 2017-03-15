# frozen_string_literal: true
require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let! (:user)      { FactoryGirl.create(:user) }
  let (:admin_user) { FactoryGirl.create(:user, :admin) }

  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'GET #show' do
    context 'when logged in' do
      before do
        sign_in user
        get :show, params: { id: user.id }
      end

      it 'responds with http success' do
        expect(response).to have_http_status(:success)
      end

      it 'populates a user variable' do
        expect(assigns(:user)).to eq(user)
      end
    end

    context 'when not logged in' do
      it 'redirects to sign_in url' do
        get :show, params: { id: 1 }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET #index' do
    context 'when logged in' do
      before do
        sign_in user
        get :index
      end

      it 'responds with http success' do
        expect(response).to have_http_status(:success)
      end

      it 'populates an array of users' do
        expect(assigns(:users)).to eq(User.all)
      end

      it 'renders the :index view' do
        expect(response).to render_template('index')
      end
    end

    context 'when not logged in' do
      it 'redirects to sign_in url' do
        get :index
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET #new' do
    context 'when logged in non-admin user' do
      it 'redirects to the root_url' do
        sign_in user
        get :new
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when logged in as an admin user' do
      before do
        sign_in admin_user
        get :new
      end

      it 'responds with success' do
        expect(response).to have_http_status(:success)
      end

      it 'creates an empty user' do
        expect(assigns(:user)).to be_a_new(User)
      end
    end
  end

  describe 'POST #create' do
    context 'when called as a non-admin user' do
      before do
        sign_in user
      end

      it 'redirects to the root_path' do
        post :create
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(root_path)
      end

      it 'does not create any user' do
        starting_user_count = User.count
        post :create
        ending_user_count = User.count
        expect(ending_user_count).to eql(starting_user_count)
      end
    end

    context 'when called as an admin user' do
      before do
        sign_in admin_user
      end

      it 'creates a new user' do
        new_user = FactoryGirl.attributes_for(:user)
        starting_user_count = User.count
        post :create, params: { user: new_user }
        ending_user_count = User.count
        expect(ending_user_count).to eql(starting_user_count + 1)
      end

      it 'redirects to the new user\'s profile page' do
        new_user = FactoryGirl.attributes_for(:user)
        post :create, params: { user: new_user }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(user_url(User.last.id))
      end
    end
  end

  describe 'GET #create' do
    puts "--- Why do any get #create calls succeed? ---"

    context 'when called as a non-admin user' do
      it 'responds with http redirect and creates no user' do
        sign_in user
        starting_user_count = User.count
        get :create
        ending_user_count = User.count
        expect(response).to have_http_status(:redirect)
        expect(ending_user_count).to eql(starting_user_count)
      end
    end

    context 'when called as an admin user' do
      it 'creates a user and responds with http redirect' do
        new_user = FactoryGirl.attributes_for(:user)
        sign_in admin_user
        starting_user_count = User.count
        get :create, params: { user: new_user }
        ending_user_count = User.count
        expect(response).to have_http_status(:redirect)
        expect(ending_user_count).to eql(starting_user_count + 1)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when called as a non-admin user' do
      it 'redirects to root_path' do
        sign_in user
        delete :destroy, params: { id: user.id }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(root_path)
      end

      it 'does not delete anyone' do
        sign_in user
        starting_user_count = User.count
        delete :destroy, params: { id: user.id }
        ending_user_count = User.count
        expect(ending_user_count).to eql(starting_user_count)
      end
    end

    context 'when called as an admin user' do
      it 'deletes the specified user' do
        sign_in admin_user
        starting_user_count = User.count
        delete :destroy, params: { id: user.id }
        ending_user_count = User.count
        expect(ending_user_count).to eql(starting_user_count - 1)
      end

      it 'redirects to users_path' do
        sign_in admin_user
        delete :destroy, params: { id: user.id }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(users_path)
      end

      it 'will not delete itself' do
        sign_in admin_user
        starting_user_count = User.count
        delete :destroy, params: { id: admin_user.id }
        ending_user_count = User.count
        expect(ending_user_count).to eql(starting_user_count)
      end
    end
  end
end
