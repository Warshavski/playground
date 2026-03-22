class RemoveAuthTokenFromUsers < ActiveRecord::Migration[7.1]
  def change
    safety_assured do
      remove_column :users, :auth_token, :string
    end
  end
end