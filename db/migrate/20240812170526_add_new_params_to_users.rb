class AddNewParamsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :about_me, :text
    add_column :users, :education, :string
    add_column :users, :work_history, :string
    add_column :users, :languages, :string
  end
end
