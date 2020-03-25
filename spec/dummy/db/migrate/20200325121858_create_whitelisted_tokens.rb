class CreateWhitelistedTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :whitelisted_tokens do |t|
      t.string :jti
      t.belongs_to :user, foreign_key: true
      t.datetime :exp

      t.timestamps
    end
    add_index :whitelisted_tokens, :jti, unique: true
  end
end
