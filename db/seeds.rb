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

vendor = Vendor.create!(email: "vendor8789898@vendor.com", password: '99999999', owner_name: 'Vendor Shrestha', shop_name:'Demo Shop', address: 'Ktm', contact_number: '9876543210')

product_category = ProductCategory.create!(name:'watch')

100.times do |i|
    Product.create!(
        name: "watch #{i}",
        brand: "Ultima",
        description: "Product details of (#{i}) Ultima Boom 311| W...",
        price: "3499",
        product_category_id: product_category.id,
        stock: 5,
        discount_percentage: 54,
        vendor_id: vendor.id
    )
end
