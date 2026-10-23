# app/controllers/users/books_controller.rb
module Users
  class BooksController < ApplicationController
    def index
      books = Users::Books.call(user: current_user)
      render json: books, each_serializer: BookSerializer
    end
  end
end
