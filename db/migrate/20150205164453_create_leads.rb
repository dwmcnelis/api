class CreateLeads < ActiveRecord::Migration
  def change
    create_table :leads, id: :uuid  do |t|
      t.uuid :user_id  # belongs_to :user
      t.string :first_name, limit: 40, default: nil
      t.string :last_name, limit: 40, default: nil
      t.string :email, limit: 254, default: nil
      t.string :phone, limit: 40, default: nil
      t.string :status, limit: 12, default: nil
      t.text :notes

      t.timestamps
    end
  end
end
