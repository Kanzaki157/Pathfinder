class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.references :user, null: false, foreign_key: true # イベントを作成したユーザーへの参照（外部キー）
      t.string :name, null: false # イベントの名前
      t.string :location, null: false # イベントの開催地
      t.string :representative, null: false # イベントの代表者
      t.datetime :start_time, null: false #開始日時
      t.datetime :end_time, null: false #終了日時
      t.text :main_products, null: false # 主な商品や内容
      t.integer :max_participants, null: false #上限人数
      t.text :description, null: false #詳細な説明
      t.string :status_based_on_count # 参加者数に基づくステータス
      t.timestamps
    end
  end
end
