module ProductsHelper

  def usd(price)
    Money.new(price* 100, "USD").format
  end

end
