class AddForeignKeyFromBooksToUsers < ActiveRecord::Migration[7.2]
  def change
    add_foreign_key :books, :users, validate: false
  end
end
