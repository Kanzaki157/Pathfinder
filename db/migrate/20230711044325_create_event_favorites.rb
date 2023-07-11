class CreateEventFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :event_favorites do |t|
      t.references :event, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
