class AddJtiToBlacklistedTokens < ActiveRecord::Migration[5.1]
  def change
    add_column :blacklisted_tokens, :jti, :string
    add_index :blacklisted_tokens, :jti, unique: true
  end
end
