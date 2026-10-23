module Users
  class Books
    def self.call(user:)
      user.books
    end
  end
end
