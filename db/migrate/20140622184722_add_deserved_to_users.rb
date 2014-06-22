class AddDeservedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :deserved, :boolean, default: false
  end
end
