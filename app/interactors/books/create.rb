module Books
  class Create
    def self.call(params)
      contract = BookContract.new(params)
      return { success: false, error: contract.errors } unless contract.valid?
      
      book = ::Book.create(params)
      if book.persisted?
        { success: true, book: book }
      else
        { success: false, error: book.errors.full_messages }
      end
    end
  end
end