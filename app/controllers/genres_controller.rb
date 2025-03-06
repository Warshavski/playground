class GenresController < ApplicationController
  def index
    genres = Genre.all
    render json: genres, each_serializer: GenreSerializer
  end

  def show
    genre = Genre.find(params[:id])
    render json: genre, serializer: GenreSerializer
  end
end
