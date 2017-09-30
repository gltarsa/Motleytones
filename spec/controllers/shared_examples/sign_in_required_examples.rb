# frozen_string_literal: true

RSpec.shared_examples "login-required actions" do
  context 'when not logged in' do
    it 'sets flash message to "You must be signed in"' do
      response
      expect(flash[:alert]).to match(I18n.t('devise.failure.unauthenticated'))
    end

    it 'redirects to sign_in url' do
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
