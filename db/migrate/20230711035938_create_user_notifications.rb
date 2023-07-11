class CreateUserNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :user_notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.references :vendor, null: false, foreign_key: true
      t.string :notification_type, null: false
      t.boolean :read_status, default: false, null: false
      t.timestamps
    end
  end
end
