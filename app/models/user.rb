class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :set_completed_registration_false
  after_invitation_accepted :set_completed_registration_true

  belongs_to :site, optional: true
  has_many :site_users

  private

  def set_completed_registration_false
    self.update(completed_registration: false)
  end

  def set_completed_registration_true
    self.update(completed_registration: true)
  end
end
