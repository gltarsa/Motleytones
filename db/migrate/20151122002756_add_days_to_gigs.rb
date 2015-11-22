class AddDaysToGigs < ActiveRecord::Migration
  def change
    add_column :gigs, :days, :integer, default: 1
  end
end
