class AddBandStartDateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :band_start_date, :date, default: "1910-01-01"
  end
end
