class ValidateBooksUserForeignKey < ActiveRecord::Migration[7.2]
  def change
    validate_foreign_key :books, :users
  end
end
