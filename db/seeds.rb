# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

#Create a vendor
vendor = Vendor.create!(email: "thirdpartyapi@vendor.com", password: '99999999', owner_name: 'Third Party Api', shop_name:'Dummy JSON', address: 'Ktm', contact_number: '9876543210')


#Add product categories from the third party api

created_product_categories = []
product_categories_resp = HTTP.get("https://dummyjson.com/products/category-list").body.to_s
product_categories = JSON.parse(product_categories_resp)
product_categories.each do |product_category|
    created_product_categories<<ProductCategory.create!(
        name: product_category
    )
end

#Add products to the database
created_product_categories.each do |product_category|
    products_resp = HTTP.get("https://dummyjson.com/products/category/#{product_category.name}").body.to_s
    products = JSON.parse(products_resp)
    products["products"].each do |product|
        Product.create!(
            name: product["title"].nil? ? "No Name" : product["title"],
            brand: product["brand"].nil? ? "No Brand" : product["brand"],
            description: product["description"].nil? ? "Dummy Description" : product["description"],
            price: product["price"].nil? ? 44 : product["price"],
            product_category_id: product_category.id,
            stock: product["stock"].to_i < 1 ? 1 : product["stock"].to_i,
            discount_percentage: product["discountPercentage"].nil? ? 0 : product["discountPercentage"],
            vendor_id: vendor.id,
            image_url: product["images"][0]
        )
    end
end