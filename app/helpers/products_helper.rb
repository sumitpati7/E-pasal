module ProductsHelper
  def calc_discounted_amount(product)
    number_with_precision(product.price.to_f - ((product.discount_percentage.to_f / 100.0)*product.price.to_f), precision: 2)
  end

  def show_price(product)
    if product.discount_percentage>0
      content_tag(:div, class: "flex justify-center gap-1 flex-col") do
        content_tag(:span, calc_discounted_amount(product), class: "text-green-600 w-full text-center text-[24px]")+
        content_tag(:span, class: "flex gap-1 justify-center") do
          content_tag(:span, product.price, class: "text-red-600 line-through") + content_tag(:span, "#{product.discount_percentage}% off", class: "text-red-800")
        end
      end
    else
      content_tag(:div, product.price, class: "text-green-600 text-center")
    end
  end

  def ProductImage(product, css)
      if product.product_image.attached?
      image_tag url_for(product.product_image), class: "#{css}", alt: product.title, title: product.title
      else
      image_tag "#{product.image_url}", alt: "#{product.title}", class: "#{css}", title: product.title
      end
  end

  def show_quantity(product)
    if product.stock > 0
      content_tag(:div, product.stock, class: "text-green-800  font-bold text-center")
    else
      content_tag(:div, "Out of Stock", class: "text-red-800 font-bold text-center")
    end
  end
end
