# frozen_string_literal: true
require 'rails_helper'

RSpec.describe GigsController, type: :controller do
  let!(:user)      { FactoryGirl.create(:user, name: "Ordinary User") }
  let(:admin_user) { FactoryGirl.create(:user, :admin, name: "Admin User") }
  let!(:gig)       { FactoryGirl.create(:gig) }

  after do
    # # NEXT: refactor tests to check for redirects and flash messages once.
   #puts "------ flash: #{flash.to_a}" unless flash.keys.empty?
  end

  def admin_required_redirect
    expect(response).to have_http_status(:redirect)
    expect(response).to redirect_to(root_path)
    expect(flash[:alert]).to match(/^You must be an admin/)
  end

  def signed_in_redirect
    expect(response).to have_http_status(:redirect)
    expect(response).to redirect_to(new_user_session_path)
    expect(flash[:alert]).to match(/^You must be signed in/)
  end

  describe 'GET #show' do
    context 'when not logged in' do
      it 'Sets flash message to "You must be signed in" and redirects to sign_in url' do
        get :show, params: { id: gig.id }
        signed_in_redirect
      end
    end

    context 'when logged in as a non-admin' do
      it 'Sets flash message to "You must be an admin" message and redirects to root' do
        sign_in user
        get :show, params: { id: gig.id }
        admin_required_redirect
      end
    end

    context 'when logged in as an admin' do
      before do
        sign_in admin_user
        get :show, params: { id: gig.id }
      end

      it 'responds with http success' do
        expect(response).to have_http_status(:success)
      end

      it 'populates an @gig variable' do
        expect(assigns(:gig)).to eq(gig)
      end
    end
  end

  describe 'GET #index' do
    context 'when not logged in' do
      it 'Sets flash message to "You must be signed in" and redirects to sign_in url' do
        get :index
        signed_in_redirect
      end
    end

    context 'when logged in as non-admin' do
      it 'Sets flash message to "You must be an admin" message and redirects to root' do
        sign_in user
        get :index
        admin_required_redirect
      end
    end

    context 'when logged in as an admin' do
      before do
        sign_in admin_user
        get :index
      end

      it 'responds with http success' do
        expect(response).to have_http_status(:success)
      end

      it 'populates @gigs with an array of gigs' do
        expect(assigns(:gigs)).to eq(Gig.all)
      end

      it 'renders the :index view' do
        expect(response).to render_template(:index)
      end
    end
  end

  describe 'GET #new' do
    context 'when not logged in' do
      it 'Sets flash message to "You must be signed in" and redirects to sign_in url' do
        get :new
        signed_in_redirect
      end
    end

    context 'when logged in non-admin user' do
      it 'Sets flash message to "You must be an admin" message and redirects to root' do
        sign_in user
        get :new
        admin_required_redirect
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

      it 'creates an empty gig' do
        expect(assigns(:gig)).to be_a_new(Gig)
      end
    end
  end

  RSpec.shared_examples_for "gigs#create tests" do |http_action|
    context 'when not logged in' do
      it 'Sets flash message to "You must be signed in" and redirects to sign_in url' do
        send http_action, :create
        signed_in_redirect
      end
    end

    context 'when called as a non-admin user' do
      before do
        sign_in user
      end

      it 'Sets flash message to "You must be an admin" message and redirects to root' do
        send http_action, :create
        admin_required_redirect
      end

      it 'does not create any gig' do
        starting_gig_count = Gig.count
        send http_action, :create
        ending_gig_count = Gig.count
        expect(ending_gig_count).to eql(starting_gig_count)
        admin_required_redirect
      end
    end

    context 'when called as an admin user' do
      before do
        sign_in admin_user
        @new_gig = FactoryGirl.attributes_for(:gig)
      end

      it 'creates a new gig' do
        starting_gig_count = Gig.count
        send http_action, :create, params: { gig: @new_gig }
        ending_gig_count = Gig.count
        expect(ending_gig_count).to eql(starting_gig_count + 1)
      end

      it 'displays a flash message containing "New gig added"' do
        send http_action, :create, params: { gig: @new_gig }
        expect(flash[:notice]).to match(/^New gig added/)
      end

      it 'redirects to the new gig\'s show page' do
        send http_action, :create, params: { gig: @new_gig }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(gig_url(Gig.last.id))
      end
    end
  end

  describe 'POST #create' do
    include_examples "gigs#create tests", :post
  end

  describe 'GET #create' do
    before do
      puts "------------ Why do any GET #create calls succeed? ---"
    end
    include_examples "gigs#create tests", :get
  end

  describe 'GET #edit' do
    context 'when not logged in' do
      it 'Sets flash message to "You must be signed in" and redirects to sign_in url' do
        get :edit, params: { id: gig.id }
        signed_in_redirect
      end
    end

    context 'when called as a non-admin user' do
      it 'Sets flash message to "You must be an admin" message and redirects to root' do
        sign_in user
        get :edit, params: { id: gig.id }
        admin_required_redirect
      end
    end

    context 'when called as an admin user' do
      it 'allows me to edit the gig' do
        sign_in admin_user
        get :edit, params: { id: gig.id }
        expect(response).to have_http_status(:success)
      end
    end
  end

  RSpec.shared_examples_for "gigs#update tests" do |http_action|
    let(:http_action) { http_action }

    before do
      @new_note = Faker::Lorem.sentence
    end

    context 'when not logged in' do
      it 'Sets flash message to "You must be signed in" and redirects to sign_in url' do
        send http_action, :update,
          params: { id: gig.id, gig: { note: @new_note } }
        signed_in_redirect
      end
    end

    context 'when called as a non-admin user' do
      it 'Sets flash message to "You must be an admin" message and redirects to root' do
        sign_in user
        send http_action, :update,
          params: { id: gig.id, gig: { note: @new_note } }
        admin_required_redirect
      end
    end

    context 'when called as an admin user' do
      it 'updates the gig' do
        sign_in admin_user
        @new_email = Faker::Internet.email
        send http_action, :update,
          params: { id: gig.id, gig: { note: @new_note } }
        gig.reload
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(gig_url(gig.id))
        expect(gig.note).to eq(@new_note)
      end
    end
  end

  describe 'PATCH #update' do
    include_examples "gigs#update tests", :patch
  end

  describe 'PUT #update' do
    include_examples "gigs#update tests", :put
  end

  describe 'DELETE #destroy' do
    context 'when not logged in' do
      it 'Sets flash message to "You must be signed in" and redirects to sign_in url' do
        delete :destroy, params: { id: gig.id }
        signed_in_redirect
      end
    end

    context 'when called as a non-admin user' do
      it 'Sets flash message to "You must be an admin" message and redirects to root' do
        sign_in user
        delete :destroy, params: { id: gig.id }
        admin_required_redirect
      end
    end

    context 'when called as an admin user' do
      before do
        sign_in admin_user
      end

      it 'deletes the specified gig' do
        starting_gig_count = Gig.count
        delete :destroy, params: { id: gig.id }
        ending_gig_count = Gig.count
        expect(ending_gig_count).to eql(starting_gig_count - 1)
      end

      it 'displays a flash notice upon deleting the gig containing "gig deleted"' do
        delete :destroy, params: { id: gig.id }
        expect(flash[:notice]).to match(/^gig deleted/)
      end

      it 'redirects to gig page for that gig' do
        delete :destroy, params: { id: gig.id }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(gigs_url)
      end
    end
  end
end
