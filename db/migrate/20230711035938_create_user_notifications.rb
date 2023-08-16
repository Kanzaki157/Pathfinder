class CreateUserNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :user_notifications do |t|
      t.references :user, null: false, foreign_key: true # ユーザーへの参照（外部キー）
      t.references :event, null: true, foreign_key: true # 投稿への参照（外部キー）
      t.string :notification_type, null: false # 通知のタイプを示す文字列
      t.boolean :read_status, default: false, null: false # 通知が既読か未読かを示すブール値
      t.timestamps
    end
  end
end
