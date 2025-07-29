module Books
  class Index
    include Interactor

    def call
      context.books = Book.all
    end
  end 
end