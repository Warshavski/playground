class AddUserToBooks < ActiveRecord::Migration[7.2]
  disable_ddl_transaction!

  def change
    add_reference :books, :user, null: true, index: { algorithm: :concurrently }
  end
end
