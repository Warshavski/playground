module Books
  class Update
    include Interactor
    
    def call
      book = ::Book.find_by(id: context.id)
      context.fail!(error: "Book not found") unless book
      if book.update(context.params) 
        context.book = book
      else
        context.fail!(error: book.errors.full_messages)
      end
    end
  end
end