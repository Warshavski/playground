class AuthorSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :biography, :born_in, :died_in
end