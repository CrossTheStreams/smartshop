class Company < ApplicationRecord

  before_create :create_postgres_user

  has_many :users
  has_many :products

  private
  
  # Create a PostgreSQL user for Row Level Security policies
  def create_postgres_user
    ActiveRecord::Base.connection.execute("CREATE ROLE #{db_user}")
  end

end
