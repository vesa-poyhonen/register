class AddPasswordResetToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :password_reset_digest, :string, after: :password_digest
    add_column :users, :password_reset_sent_at, :datetime, after: :password_reset_digest
  end
end
