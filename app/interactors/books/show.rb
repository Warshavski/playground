module Books
  class Show
    include Interactor

    def call
      book = ::Book.find_by(id: context.id)
      return context.fail!(error: "Book not found") unless book
      context.book = book
    end
  end
end
