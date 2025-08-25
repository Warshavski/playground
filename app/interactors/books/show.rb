module Books
  class Show
    def self.call(id:)
      book = ::Book.find_by(id: id)
      if book
        { success: true, book: book }
      else
        { success: false, error: "Book not found" }
      end
    end
  end
end