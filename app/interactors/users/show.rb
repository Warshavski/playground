module Users
  class Show
    def self.call(id:)
      user = ::User.find_by(id:)
      if user
        { success: true, user: }
      else
        { success: false, error: I18n.t('users.errors.not_found') }
      end
    end
  end
end
