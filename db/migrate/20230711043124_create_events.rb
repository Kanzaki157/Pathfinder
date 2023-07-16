class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.references :user, null: false, foreign_key: true # イベントを作成したユーザーへの参照（外部キー）
      t.string :name # イベントの名前
      t.string :closed_on # イベントが終了する日付
      t.string :location, null: false # イベントの開催地
      t.string :representative, null: false # イベントの代表者
      t.integer :fax_number # イベントの代表者
      t.integer :phone_number, null: false # 電話番号
      t.string :opening_hours # 開催時間
      t.datetime :start_time #開始日時
      t.datetime :end_time #終了日時
      t.text :main_products, null: false # 主な商品や内容
      t.decimal :price, null: false # 価格
      t.text :access_info # アクセス情報
      t.integer :max_participants, null: false #上限人数
      t.string :website_url # ウェブサイトのURL
      t.string :google_map_url # GoogleマップのURL
      t.text :contact_info # 連絡先情報
      t.text :description #詳細な説明
      t.text :reservation_info # 予約に関する情報
      t.string :status_based_on_count, null: false # 参加者数に基づくステータス
      t.timestamps
    end
  end
end
