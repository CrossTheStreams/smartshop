class ProductsController < ApplicationController

  def index
    @products = current_user.company.products
    render :index
  end

end
