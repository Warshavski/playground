# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users::RegistrationsController', type: :request do
  def json_response
    JSON.parse(response.body)
  end

  describe 'POST /users' do
    context 'when params valid' do
      subject do
        post signup_path,
             params: valid_params,
             headers: { 'Accept' => 'application/json' }
      end

      let(:valid_params) do
        {
          user: {
            email: 'new_user_dasha@example.com',
            password: 'dsggh88w_!6',
            password_confirmation: 'dsggh88w_!6'
          }
        }
      end

      it 'creates user' do
        expect { subject }.to change(User, :count).by(1)
        expect(response).to have_http_status(:created)
      end

      it 'return created user' do
        subject

        expect(json_response['user']['email']).to eq('new_user_dasha@example.com')
        expect(json_response['user']['id']).to be_present
      end
    end

    context 'when params invalid' do
      subject do
        post signup_path,
             params: invalid_params,
             headers: { 'Accept' => 'application/json' }
      end

      let(:invalid_params) do
        {
          user: {
            email: '',
            password: 'gh',
            password_confirmation: 'dhdhh'
          }
        }
      end

      it 'returns errors' do
        subject
        expect(json_response['errors']).to be_present
      end
    end
  end
end
