class Product < ApplicationRecord

  self.primary_key = :id

  belongs_to :company

end
