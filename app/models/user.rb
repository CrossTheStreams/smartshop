class User < ApplicationRecord

  belongs_to :company

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  def self.find_for_authentication(warden_conditions)
    lookup_user = Smartshop::MultiTenancy.with_schema("public") do
      LookupUser.where(:email => warden_conditions[:email]).first
    end
    user_schema = lookup_user.schema_name
    Smartshop::MultiTenancy.with_schema(user_schema) do
      where(:email => warden_conditions[:email]).first
    end
  end

end
