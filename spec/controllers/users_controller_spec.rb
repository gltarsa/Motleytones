# frozen_string_literal: true
require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:user)      { FactoryGirl.create(:user, name: "Ordinary User") }
  let(:admin_user) { FactoryGirl.create(:user, :admin, name: "Admin User") }

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

  RSpec.shared_examples_for "users#create tests" do |http_action|
    context 'when called as a non-admin user' do
      before do
        sign_in user
      end

      it 'redirects to the root_path' do
        send http_action, :create
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(root_path)
      end

      it 'does not create any user' do
        starting_user_count = User.count
        send http_action, :create
        ending_user_count = User.count
        expect(ending_user_count).to eql(starting_user_count)
      end
    end

    context 'when called as an admin user' do
      before do
        sign_in admin_user
        @new_user = FactoryGirl.attributes_for(:user)
      end

      it 'creates a new user' do
        starting_user_count = User.count
        send http_action, :create, params: { user: @new_user }
        ending_user_count = User.count
        expect(ending_user_count).to eql(starting_user_count + 1)
      end

      it 'displays a flash message containing "New Pirate Added"' do
        send http_action, :create, params: { user: @new_user }
        expect(flash[:notice]).to match(I18n.t('devise.registrations.new_pirate_added',
                                               count: User.count))
      end

      it 'redirects to the new user\'s profile page' do
        send http_action, :create, params: { user: @new_user }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(user_url(User.last.id))
      end
    end
  end

  describe 'POST #create' do
    include_examples "users#create tests", :post
  end

  describe 'GET #create' do
    before do
      puts "------------ Why do any GET #create calls succeed? ---"
    end
    include_examples "users#create tests", :get
  end

  describe 'GET #edit' do
    let(:other_user) { FactoryGirl.create(:user) }

    context 'when called as a non-admin user' do
      before do
        sign_in user
      end

      it 'allows me to edit myself' do
        get :edit, params: { id: user.id }
        expect(response).to have_http_status(:success)
      end

      it 'does not allow me to edit other users' do
        get :edit, params: { id: other_user.id }
        expect(response).to have_http_status(:redirect)
      end

      it 'redirects me to the my profile page with an alert' do
        get :edit, params: { id: other_user.id }
        expect(response).to redirect_to(user_path(user.id))
        expect(flash[:alert]).to match(I18n.t('devise.registrations.user.must_be_admin'))
      end
    end

    context 'when called as an admin user' do
      before do
        sign_in admin_user
      end

      it 'allows me to edit myself' do
        get :edit, params: { id: user.id }
        expect(response).to have_http_status(:success)
      end

      it 'allows me to edit other users' do
        get :edit, params: { id: other_user.id }
        expect(response).to have_http_status(:success)
      end

      # test for a reported bug
      # This may need to be part of the #update tests
      it 'when I edit other users I remain in logged in as myself' do
        get :edit, params: { id: other_user.id }
        expect(subject.current_user).to eq admin_user
        pending "This is not working correctly"
        fail
      end
    end
  end

  RSpec.shared_examples_for "users#update tests" do |http_action|
    let(:http_action) { http_action }
    let(:other_user) { FactoryGirl.create(:user) }

    before do
      sign_in user
      @new_email = Faker::Internet.email
    end

    context 'when called as a non-admin user' do
      it 'allows me to update myself' do
        send http_action, :update,
             params: { id: user.id, user: { email: @new_email } }
        user.reload
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(users_url)
        expect(user.email).to eq(@new_email)
      end

      it 'does not allow me to edit other users' do
        old_email = other_user.email
        send http_action, :update,
             params: { id: other_user.id, user: { email: @new_email } }
        user.reload
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(user_path(user.id))
        expect(other_user.email).to eq(old_email)
      end
    end

    context 'when called as an admin user' do
      before do
        sign_in admin_user
        @new_email = Faker::Internet.email
      end

      it 'allows me to edit myself' do
        send http_action, :update,
             params: { id: user.id, user: { email: @new_email } }
        user.reload
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(users_url)
        expect(user.email).to eq(@new_email)
      end

      it 'allows me to edit other users' do
        send http_action, :update,
             params: { id: other_user.id, user: { email: @new_email } }
        other_user.reload
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(users_url)
        expect(other_user.email).to eq(@new_email)
        expect(subject.current_user).to eq admin_user
      end
    end
  end

  describe 'PATCH #update' do
    include_examples "users#update tests", :patch
  end

  describe 'PUT #update' do
    include_examples "users#update tests", :put
  end

  describe 'DELETE #destroy' do
    context 'when called as a non-admin user' do
      it 'redirects to root_path' do
        sign_in user
        delete :destroy, params: { id: user.id }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when called as an admin user' do
      before do
        sign_in admin_user
      end

      it 'deletes the specified user' do
        starting_user_count = User.count
        delete :destroy, params: { id: user.id }
        ending_user_count = User.count
        expect(ending_user_count).to eql(starting_user_count - 1)
      end

      it 'displays a flash notice upon deleting the user containing "Pirate has been killed"' do
        delete :destroy, params: { id: user.id }
        expect(flash[:notice]).to match(I18n.t('devise.registrations.pirate_deleted',
                                               count: User.count))
      end

      it 'redirects to users_path' do
        delete :destroy, params: { id: user.id }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(users_path)
      end

      it 'will not delete itself' do
        starting_user_count = User.count
        delete :destroy, params: { id: admin_user.id }
        ending_user_count = User.count
        expect(ending_user_count).to eql(starting_user_count)
      end
    end
  end
end
