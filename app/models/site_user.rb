class SiteUser < ApplicationRecord
  belongs_to :site
  belongs_to :user

  enum :roles, [ :creator, :member ]

  ransacker :roles do |parent|
    Arel.sql("CASE #{parent.table.name}.roles
               WHEN 0 THEN 'creator'
               WHEN 1 THEN 'member'
               END")
  end

  # ransacker :roles, formatter: proc { |v| roles[v] } do |parent|
  #   Arel.sql("CAST(#{parent.table.name}.roles AS TEXT)")
  # end

  def self.ransackable_attributes(auth_object = nil)
    [ "roles" ]
  end
end
