class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  # пока не нужно. в след версии для OAuth authorization раскомитить
  # has_many :access_grants,
  #          class_name: 'Doorkeeper::AccessGrant',
  #          foreign_key: :resource_owner_id,
  #          dependent: :delete_all # or :destroy if you need callbacks

  has_many :access_tokens,
           class_name: 'Doorkeeper::AccessToken',
           foreign_key: :resource_owner_id,
           dependent: :delete_all # or :destroy if you need callbacks

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
