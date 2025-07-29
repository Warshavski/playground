module Books
  class Create
    include Interactor

    def call
      contract = BookContract.new(context.params)
      unless contract.valid?
        context.fail!(error: contract.errors)
        return
      end

      book = ::Book.create(context.params)
      if book.persisted?
        context.book = book
      else
        context.fail!(error: book.errors.full_messages)
      end
    end
  end
end