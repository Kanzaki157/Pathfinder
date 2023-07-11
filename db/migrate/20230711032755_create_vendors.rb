class CreateVendors < ActiveRecord::Migration[6.1]
  def change
    create_table :vendors do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :vendor_is_delete, default: false, null: false
      t.integer :payment_method, null: false
      t.integer :invoice_amount, null: false
      t.timestamps
    end
  end
end
