class AddSiteReferencesToUsers < ActiveRecord::Migration[7.2]
  def change
    add_reference :users, :site, foreign_key: true
  end
end
