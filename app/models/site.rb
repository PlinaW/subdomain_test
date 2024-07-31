class Site < ApplicationRecord
  has_many :site_users, dependent: :destroy
  has_many :users, through: :site_users
end
