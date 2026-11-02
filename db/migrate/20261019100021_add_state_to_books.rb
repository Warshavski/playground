
class AddStateToBooks < ActiveRecord::Migration[7.2]
  disable_ddl_transaction!

  def change
    add_column :books, :state, :string,
               default: 'draft',
               null: false

    add_index :books, :state,
              algorithm: :concurrently
  end
end
