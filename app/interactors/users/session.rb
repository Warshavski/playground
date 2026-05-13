# frozen_string_literal: true

module Users
  class Session
    APPLICATION_NAME = 'Books API'

    def self.call(email:, password:)
      user = User.find_by(email:)

      unless user&.valid_password?(password)
        return { success: false, error: I18n.t('users.errors.invalid_email_password') }
      end

      oauth_application = Doorkeeper::Application.find_by!(name: APPLICATION_NAME)

      access_token = Doorkeeper::AccessToken.create!(
        application_id: oauth_application.id,
        resource_owner_id: user.id,
        scopes: '',
        expires_in: Doorkeeper.configuration.access_token_expires_in.to_i,
        use_refresh_token: true
      )

      {
        success: true,
        user:,
        access_token:
      }
    end
  end
end
