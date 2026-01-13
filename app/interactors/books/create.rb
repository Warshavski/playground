module Books
  class Create
    def self.call(params)
      contract = BookContract.new.call(params.to_h)
      return { success: false, error: contract.errors.to_h } if contract.failure?
      
      book = ::Book.create(params)
      if book.persisted?
        { success: true, book: book }
      else
        { success: false, error: book.errors.full_messages }
      end
    end
  end
end