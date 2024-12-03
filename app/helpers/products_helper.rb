module ProductsHelper
  def calc_discounted_amount(price, discount_percentage)
    number_with_precision(price.to_f - ((discount_percentage.to_f / 100.0)*price.to_f), precision: 2)
  end
end
