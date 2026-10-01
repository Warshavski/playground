module Books
  class Create
    def self.call(params:, user:)
      contract = BookContract.new.call(params.to_h)
      return { success: false, error: contract.errors.to_h } if contract.failure?

      book = user.books.create(params)

      if book.persisted?
        { success: true, book: }
      else
        { success: false, error: book.errors.full_messages }
      end
    end
  end
end
