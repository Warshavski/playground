class BookSerializer < ActiveModel::Serializer
  attributes :id, :title, :weight, :pages_count, :description, :isbn13, :isbn10, :published_in

  attribute :publisher_name
  attribute :authors
  attribute :genres

  def publisher_name
    object.publisher.name
  end

  def authors
    object.authors.map do |author|
      {
        first_name: author.first_name,
        last_name: author.last_name
      }
    end
  end

  def genres
    object.genres.map { |a| a.name }
  end
end
