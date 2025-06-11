class GenreSerializer < ActiveModel::Serializer
  attributes :id, :name, :description
  
  has_many :books
end
