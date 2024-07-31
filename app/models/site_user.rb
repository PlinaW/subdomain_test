class SiteUser < ApplicationRecord
  belongs_to :site
  belongs_to :user

  enum :roles, [ :creator, :member ]
end
