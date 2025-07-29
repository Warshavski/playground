class PublisherSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :phone, :address, :postcode
end