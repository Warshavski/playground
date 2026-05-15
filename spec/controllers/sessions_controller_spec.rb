# # frozen_string_literal: true

# require 'rails_helper'

# RSpec.describe 'Users::SessionsController', type: :request do
#   let!(:user) { create(:user, email: 'dasha@example.com', password: 'dsggh88w_!6') }

#   let!(:oauth_application) do
#     Doorkeeper::Application.find_or_create_by!(name: 'Books API') do |application|
#       application.redirect_uri = 'https://dasa.com'
#     end
#   end

#   def json_response
#     JSON.parse(response.body)
#   end

#   describe 'POST /users/sign_in' do
#     context 'when params are valid' do
#       subject do
#         post user_session_path,
#              params: valid_params,
#              headers: { 'Accept' => 'application/json' }
#       end

#       let(:valid_params) do
#         {
#           user: {
#             email: 'dasha@example.com',
#             password: 'dsggh88w_!6'
#           }
#         }
#       end

#       it 'returns success' do
#         subject
#         expect(response).to have_http_status(:ok)
#       end

#       it 'returns user and tokens' do
#         subject

#         expect(json_response['user']['id']).to eq(user.id)
#         expect(json_response['user']['email']).to eq(user.email)
#         expect(json_response['access_token']).to be_present
#         expect(json_response['token_type']).to eq('Bearer')
#         expect(json_response['expires_in']).to be_present
#         expect(json_response['refresh_token']).to be_present
#       end
#     end

#     context 'when password is invalid' do
#       subject do
#         post user_session_path,
#              params: invalid_params,
#              headers: { 'Accept' => 'application/json' }
#       end

#       let(:invalid_params) do
#         {
#           user: {
#             email: 'dasha@example.com',
#             password: 'wrong_password_dasha'
#           }
#         }
#       end

#       it 'returns unauthorized' do
#         subject
#         expect(response).to have_http_status(:unauthorized)
#       end

#       it 'returns error message' do
#         subject
#         expect(json_response['error']).to eq(I18n.t('users.errors.invalid_email_password'))
#       end
#     end
#   end
# end
