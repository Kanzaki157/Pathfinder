class CreateVendorNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :vendor_notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.references :vendor, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.string :notification_type, null: false
      t.boolean :read_status, default: false
      t.timestamps
    end
  end
end
