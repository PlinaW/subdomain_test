class AddHobbiesToUser < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :hobbies, :text
  end
end
