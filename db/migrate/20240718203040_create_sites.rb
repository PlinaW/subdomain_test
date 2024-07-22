class CreateSites < ActiveRecord::Migration[7.2]
  def change
    create_table :sites do |t|
      t.string :subdomain
      t.string :name
      t.string :background_color
      t.string :primary_color

      t.timestamps
    end
  end
end
