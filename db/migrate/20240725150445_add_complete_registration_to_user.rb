class AddCompleteRegistrationToUser < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :completed_registration, :boolean
  end
end
