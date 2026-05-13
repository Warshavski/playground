module Users
  class Registration
    def self.call(params:)
      user = ::User.new(params)

      if user.save
        { success: true, user: }
      else
        { success: false, error: user.errors.full_messages }
      end
    end
  end
end
