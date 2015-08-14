class AddToneNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :tone_name, :string
  end
end
