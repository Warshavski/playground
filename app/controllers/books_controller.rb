class BooksController < ApplicationController
  def index
    result = Books::Index.call
    render json: result.books, each_serializer: BookSerializer
  end

  def show
    result = Books::Show.call(id: params[:id]) 
    if result.success?
      render json: result.book, serializer: BookSerializer
    else
      render json: { error: result.error }, status: :not_found
    end
  end
  
  def create 
    result = Books::Create.call(params: book_params)
    if result.success?
      render json: result.book, serializer: BookSerializer, status: :created 
    else
      render json: { errors: result.error }
    end
  end

  def update 
    result = Books::Update.call(params: book_params, id: params[:id])
    if result.success?
      render json: result.book, serializer: BookSerializer
    else
      render json: { errors: result.error }
    end
  end

  def destroy
    result = Books::Delete.call(id: params[:id])
    if result.success?
      head :no_content
    else
      render json: { error: result.error }, status: :not_found
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :published_in, :publisher_id, :weight, :pages_count, :description, :isbn13, :isbn10, genre_ids: [], author_ids: [])
  end
    
end
