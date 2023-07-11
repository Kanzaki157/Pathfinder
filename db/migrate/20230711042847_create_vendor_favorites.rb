class CreateVendorFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :vendor_favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :vendor, null: false, foreign_key: true
      t.timestamps
    end
  end
end
