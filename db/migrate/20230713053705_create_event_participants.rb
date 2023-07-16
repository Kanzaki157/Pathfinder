class CreateEventParticipants < ActiveRecord::Migration[6.1]
  def change
    create_table :event_participants do |t|
      t.references :user, null: false, foreign_key: true # イベントに参加するユーザーへの参照（外部キー）
      t.references :event, null: false, foreign_key: true # 参加するイベントへの参照（外部キー）
      t.timestamps
    end
  end
end
