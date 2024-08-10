# frozen_string_literal: true

require 'rails_helper'
require 'controllers/shared_examples/sign_in_required_examples.rb'
require 'controllers/shared_examples/admin_required_examples.rb'

RSpec.describe UsersController, type: :controller do
  let!(:user)      { FactoryBot.create(:user, name: 'Ordinary User') }
  let(:admin_user) { FactoryBot.create(:user, :admin, name: 'Admin User') }

  describe 'GET #show' do
    let(:response) { get :show, params: { id: user.id } }

    it_behaves_like 'login-required actions'

    context 'when logged in' do
      before do
        sign_in user
        response
      end

      it 'responds with http success' do
        expect(response).to have_http_status(:success)
      end

      it 'populates an @user variable' do
        expect(assigns(:user)).to eq(user)
      end
    end
  end

  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'GET #index' do
    let(:response) { get :index }

    it_behaves_like 'login-required actions'

    context 'when logged in' do
      before do
        sign_in user
        response
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
  end

  describe 'GET #new' do
    let(:response) { get :new }

    it_behaves_like 'login-required actions'
    it_behaves_like 'admin-required actions'

    context 'when logged in as an admin user' do
      before do
        sign_in admin_user
        response
      end

      it 'responds with success' do
        expect(response).to have_http_status(:success)
      end

      it 'creates an empty user' do
        expect(assigns(:user)).to be_a_new(User)
      end
    end
  end

  RSpec.shared_examples_for 'users#create tests' do
    context 'when called as an admin user' do
      before do
        sign_in admin_user
        @new_user = FactoryBot.attributes_for(:user)
      end

      it 'creates a new user' do
        expect { response }.to change { User.count }.by 1
      end

      it 'displays a flash message containing "New pirate added"' do
        expect(response).to have_http_status(:redirect)
        expect(flash[:notice]).to match(I18n.t('devise.registrations.new_pirate_added',
                                               count: User.count))
      end

      it 'redirects to the new user\'s profile page' do
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(user_url(User.last.id))
      end
    end
  end

  describe 'POST #create' do
    let(:response) { post :create, params: { user: @new_user } }

    it_behaves_like "login-required actions"
    it_behaves_like "admin-required actions"
    include_examples 'users#create tests'
  end

  describe 'GET #edit' do
    let(:response) { get :edit, params: { id: user.id } }
    let(:other_user) { FactoryBot.create(:user) }

    it_behaves_like "login-required actions"

    context 'when called as a non-admin user' do
      before do
        sign_in user
        response
      end

      context 'when editing myself' do
        it 'allows me to edit myself' do
          expect(response).to have_http_status(:success)
        end
      end

      context 'when editing others' do
        let(:response) { get :edit, params: { id: other_user.id } }

        it 'sets flash message to "You must be signed in"' do
          expect(response).to have_http_status(:redirect)
          expect(flash[:alert]).to match(I18n.t('devise.registrations.user.must_be_admin'))
        end

        it 'redirects to the index page' do
          expect(response).to have_http_status(:redirect)
          expect(response).to redirect_to(users_path)
        end
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
    end
  end

  RSpec.shared_examples_for 'users#update tests' do
    let(:other_user) { FactoryBot.create(:user) }
    let(:new_email_params) { { email: Faker::Internet.email } }

    it_behaves_like 'login-required actions'

    context 'when called as a non-admin user' do
      context 'when I update myself' do
        before do
          sign_in user
          response
        end

        it 'my record is updated' do
          user.reload
          expect(user.email).to eq(new_email_params[:email])
        end

        it 'sets flash message to "Pirate info updated"' do
          expect(flash[:notice]).to match(I18n.t('devise.registrations.pirate_updated'))
        end

        it 'redirects to index page' do
          expect(response).to have_http_status(:redirect)
          expect(response).to redirect_to(users_url)
          user.reload
          expect(user.email).to eq(new_email_params[:email])
        end
      end

      context 'when I update others' do
        before do
          sign_in user
          response_other
        end

        it 'no update occurs' do
          old_email = other_user.email
          user.reload
          expect(other_user.email).to eq(old_email)
        end

        it 'sets the flash msg to "must be admin"' do
          expect(flash[:alert]).to match(I18n.t('devise.registrations.user.must_be_admin'))
        end

        it 'redirects to index path' do
          expect(response_other).to have_http_status(:redirect)
          expect(response_other).to redirect_to(users_path)
        end
      end
    end

    context 'when called as an admin user' do
      before do
        sign_in admin_user
        response_other
      end

      it 'allows me to edit other users' do
        other_user.reload
        expect(other_user.email).to eq(new_email_params[:email])
        expect(subject.current_user).to eq admin_user
      end

      it 'redirects to index page' do
        expect(response_other).to have_http_status(:redirect)
        expect(response_other).to redirect_to(users_url)
      end
    end
  end

  describe 'PATCH #update' do
    let(:response) { patch :update, params: { id: user.id, user: new_email_params } }
    let(:response_other) { patch :update, params: { id: other_user.id, user: new_email_params } }

    include_examples 'users#update tests', :patch
  end

  describe 'PUT #update' do
    let(:response) { put :update, params: { id: user.id, user: new_email_params } }
    let(:response_other) { patch :update, params: { id: other_user.id, user: new_email_params } }

    include_examples 'users#update tests', :put
  end

  describe 'DELETE #destroy' do
    let(:response) { delete :destroy, params: { id: user.id } }

    it_behaves_like "login-required actions"
    it_behaves_like "admin-required actions"

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
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(users_path)
      end

      context 'when trying to delete his own account' do
        it 'will not delete itself' do
          starting_user_count = User.count
          delete :destroy, params: { id: admin_user.id }
          ending_user_count = User.count
          expect(ending_user_count).to eql(starting_user_count)
        end

        it 'Sets the flash message to "You cannot delete your own account"' do
          delete :destroy, params: { id: admin_user.id }
          expect(flash[:alert])
            .to match(I18n.t('devise.registrations.user.cannot_delete_own_account'))
        end
      end
    end
  end
end
