class Company < ApplicationRecord

  self.primary_key = :id

  has_many :users
  has_many :products

end
