# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: "" # メールアドレス
      t.string :encrypted_password, null: false, default: "" # 暗号化されたパスワード

      ## Recoverable
      t.string   :reset_password_token # パスワードリセットのトークン
      t.datetime :reset_password_sent_at # パスワードリセットのトークンが送信された時間

      ## Rememberable
      t.datetime :remember_created_at # ユーザーが「ログインしたままにする」を選んだ時間

      ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.string   :current_sign_in_ip
      # t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at
      t.string  :last_name,       null: false # 姓
      t.string  :first_name,      null: false # 名
      t.string  :last_name_kana,  null: false # 姓（カナ）
      t.string  :first_name_kana, null: false # 名（カナ）
      t.string  :address,         null: false # 住所
      t.string  :post_code,       null: false # 郵便番号
      t.string  :phone_number,    null: false # 電話番号
      t.boolean :is_delete,       null: false, default: false # ユーザーが削除されたかどうか

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true # メールアドレスはユニークであること
    add_index :users, :reset_password_token, unique: true # パスワードリセットトークンもユニークであること
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end
