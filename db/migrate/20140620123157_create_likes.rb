class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.string :user_id
      t.string :answer_id
    end
    add_index :likes, :user_id
    add_index :likes, :answer_id
  end
end
