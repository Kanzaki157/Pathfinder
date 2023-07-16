class CreateEventFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :event_favorites do |t|
      t.references :event, null: false, foreign_key: true # お気に入りのイベントへの参照（外部キー）
      t.references :user, null: false, foreign_key: true # お気に入りを登録したユーザーへの参照（外部キー）

      t.timestamps
    end
  end
end
