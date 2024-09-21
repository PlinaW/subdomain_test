class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :set_completed_registration_false
  after_invitation_accepted :set_completed_registration_true

  belongs_to :site, optional: true
  has_many :site_users

  validates :first_name, presence: true
  validates :last_name, presence: true

  ransacker :full_name do |parent|
    Arel::Nodes::NamedFunction.new("concat", [
      parent.table[:first_name],
      Arel::Nodes::Quoted.new(" "),
      parent.table[:last_name]
    ])
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "full_name", "first_name", "last_name", "country", "email" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "site_users" ]
  end

  def full_name
    return "#{first_name} #{last_name}" if first_name || last_name

    "Anonymous"
  end

  def full_address
    "#{address}, #{zip_code}, #{city},"
  end

  private

  def set_completed_registration_false
    self.update(completed_registration: false)
  end

  def set_completed_registration_true
    self.update(completed_registration: true)
  end
end
