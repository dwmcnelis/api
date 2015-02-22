class CreateCredentials < ActiveRecord::Migration
  def change
    create_table :credentials, id: :uuid do |t|
      t.uuid :user_id  # belongs_to :user
      t.string :password_digest, limit: 130, default: nil
      t.string :signature_nonce, limit: 90, default: nil
      t.integer :multi_factor, limit: 1, null: false, default: 0
      t.string :multi_factor_secret, limit: 46, default: nil
      t.integer :multi_factor_counter, limit: 2, null: false, default: 0
      t.integer :multi_factor_phone, limit: 1, null: false, default: 0
      t.string :multi_factor_phone_number, limit: 25, default: nil
      t.integer :multi_factor_phone_backup, limit: 1, null: false, default: 0
      t.string :multi_factor_phone_backup_number, limit: 25, default: nil
      t.integer :multi_factor_authenticator, limit: 1, null: false, default: 0
      t.text :multi_factor_backup_codes

      t.timestamps
    end
  end
end