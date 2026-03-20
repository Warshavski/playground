module Users
  class Update
    def self.call(id:, params:)
      user = User.find_by(id:)
      return { success: false, error: I18n.t('users.errors.not_found') } unless user

      if user.update(params)
        { success: true, user: }
      else
        { success: false, error: user.errors.full_messages }
      end
    end
  end
end
