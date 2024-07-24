class RemoveSiteFromUsers < ActiveRecord::Migration[7.2]
  def change
    remove_column :users, :site_id, :bigint
  end
end
