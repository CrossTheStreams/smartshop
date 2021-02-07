class User < ApplicationRecord

  belongs_to :company

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  def self.find_for_authentication(warden_conditions)
    where(:email => warden_conditions[:email]).first
  end

end
