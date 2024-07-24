class CreateSiteUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :site_users do |t|
      t.references :site, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :roles

      t.timestamps
    end
  end
end
