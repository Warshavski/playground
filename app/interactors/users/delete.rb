module Users
  class Delete
    def self.call(id:)
      user = ::User.find_by(id:)
      return { success: false, error: I18n.t('users.errors.not_found') } unless user

      if user.destroy
        { success: true, user: }
      else
        { success: false, error: user.errors.full_messages }
      end
    end
  end
end
