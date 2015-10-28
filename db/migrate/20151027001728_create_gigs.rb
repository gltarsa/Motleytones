class CreateGigs < ActiveRecord::Migration
  def change
    create_table :gigs do |t|
      t.date :date
      t.text :name
      t.text :note
      t.text :location
      t.boolean :published

      t.timestamps null: false
    end
  end
end
