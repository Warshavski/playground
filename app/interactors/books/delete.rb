module Books
  class Delete
    def self.call(id:)
      book = ::Book.find_by(id:)
      return { success: false, error: 'Book not found' } unless book

      if book.destroy
        { success: true, book: }
      else
        { success: false, error: book.errors.full_messages }
      end
    end
  end
end
