class Event < ApplicationRecord
  # def google_calendar_url
  #   base_url = "https://www.google.com/calendar/render?action=TEMPLATE"
  #   text = "&text=#{URI.encode(name)}"
  #   dates = "&dates=#{start_date.strftime('%Y%m%dT%H%M%SZ')}/#{end_date.strftime('%Y%m%dT%H%M%SZ')}"
  #   details = "&details=#{URI.encode(details)}"
  #   location = "&location=#{URI.encode(location)}"
  #   "#{base_url}#{text}#{dates}#{details}#{location}"
  # end
  belongs_to :user
    # 関連付け
  has_many :event_participants  # Eventが参加者と関連付けされています
  has_many :users, through: :event_participants  # EventがUserと中間テーブルを通じて関連付けされています
  has_many :event_favorites  # Eventがお気に入りと関連付けされています
  
  # バリデーション
  validates :representative, presence: true  # 企業名または企画名が存在すること
  validates :location, presence: true  # 開催地が存在すること
  validates :phone_number, presence: true, numericality: { only_integer: true }  # 電話番号が存在し、整数であること
  validates :closed_on, presence: true  # 定休日が存在すること
  validates :fax_number, numericality: { only_integer: true }, allow_blank: true  # FAX番号が整数であること（空白可）
  validates :opening_hours, presence: true  # 営業時間が存在すること
  validates :main_products, presence: true  # 主要商品が存在すること
  validates :price, numericality: true  # 料金・価格が数値であること
  validates :access_info, presence: true  # 交通・アクセス情報が存在すること
  validates :website_url, format: { with: URI::regexp(%w(http https)) }, allow_blank: true  # マイホームページURLがhttpまたはhttpsで始まること（空白可）
  validates :google_map_url, format: { with: URI::regexp(%w(http https)) }, allow_blank: true  # GoogleマップURLがhttpまたはhttpsで始まること（空白可）
  validates :contact_info, presence: true  # お問い合わせ情報が存在すること
  
end
