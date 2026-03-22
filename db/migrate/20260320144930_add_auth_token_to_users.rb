class AddAuthTokenToUsers < ActiveRecord::Migration[7.1]
  disable_ddl_transaction!

  def change
    add_column :users, :auth_token, :string
    add_index :users, :auth_token, unique: true, algorithm: :concurrently
  end
end