class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :set_completed_registration

  belongs_to :site, optional: true
  has_many :site_users

  private

  def set_completed_registration
    self.update(completed_registration: false)
  end
  
end
