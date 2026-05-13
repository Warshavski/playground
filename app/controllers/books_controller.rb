class BooksController < ApplicationController
  before_action :doorkeeper_authorize!, only: %i[create update destroy]

  def index
    books = Books::Index.call
    render json: books, each_serializer: BookSerializer
  end

  def show
    result = Books::Show.call(id: params[:id])
    render_book_result(result, error_status: :not_found)
  end

  def create
    result = Books::Create.call(book_params)
    render_book_result(result, success_status: :created, error_status: :unprocessable_entity)
  end

  def update
    result = Books::Update.call(params: book_params, id: params[:id])
    render_book_result(result, error_status: :unprocessable_entity)
  end

  def destroy
    result = Books::Delete.call(id: params[:id])

    if result[:success]
      head :no_content
    else
      render json: { errors: result[:error] }, status: :not_found
    end
  end

  private

  def render_book_result(result, success_status: :ok, error_status: :unprocessable_entity)
    if result[:success]
      render json: result[:book], serializer: BookSerializer, status: success_status
    else
      render json: { errors: result[:error] }, status: error_status
    end
  end

  def book_params
    params.require(:book).permit(:title, :published_in, :publisher_id, :weight, :pages_count, :description, :isbn13,
                                 :isbn10, genre_ids: [], author_ids: [])
  end
end
