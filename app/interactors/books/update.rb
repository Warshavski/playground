module Books
  class Update
    def self.call(params:, id:)
      book = ::Book.find_by(id: id)
      return { success: false, error: "Book not found" } unless book

      if book.update(params)
        { success: true, book: book }
      else
        { success: false, error: book.errors.full_messages }
      end
    end
  end
end