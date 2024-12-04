module ProductsHelper
  def calc_discounted_amount(price, discount_percentage)
    number_with_precision(price.to_f - ((discount_percentage.to_f / 100.0)*price.to_f), precision: 2)
  end
    def ProductImage(product, css)
       if product.product_image.attached?
        image_tag url_for(product.product_image), class: "#{css}", alt: product.title
       else
        image_tag "#{product.image_url}", alt: "#{product.title}", class: "#{css}"
       end
    end
end
