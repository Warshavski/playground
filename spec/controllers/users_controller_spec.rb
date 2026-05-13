# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  def json_response
    JSON.parse(response.body)
  end

  describe 'GET /users/:id' do
    subject { get user_path(user), headers: { 'Accept' => 'application/json' } }

    let(:user) { create(:user) }

    it 'return successful response' do
      subject
      expect(response).to have_http_status(:ok)
    end

    it 'return correct user' do
      subject
      expect(json_response['user']['id']).to eq(user.id)
      expect(json_response['user']['email']).to eq(user.email)
    end
  end

  describe 'PATCH /users/:id' do
    subject do
      patch user_path(user),
            params: update_params,
            headers: { 'Accept' => 'application/json' }
    end

    let(:user) { create(:user, email: 'old@example.com') }

    let(:update_params) do
      {
        user: {
          email: 'dasha@example.com'
        }
      }
    end

    it 'update user and return success' do
      subject
      expect(response).to have_http_status(:ok)
      expect(json_response['user']['email']).to eq('dasha@example.com')
      expect(user.reload.email).to eq('dasha@example.com')
    end
  end

  describe 'DELETE /users/:id' do
    subject do
      delete user_path(user), headers: { 'Accept' => 'application/json' }
    end

    let!(:user) { create(:user) }

    it 'delete user' do
      expect { subject }.to change(User, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end
