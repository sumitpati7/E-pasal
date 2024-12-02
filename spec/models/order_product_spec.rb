# == Schema Information
#
# Table name: order_products
#
#  id         :bigint           not null, primary key
#  order_id   :bigint           not null
#  product_id :bigint           not null
#  quantity   :integer          not null
#  status     :string           default("pending"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe OrderProduct, type: :model do
    # pending "add some examples to (or delete) #{__FILE__}"
    # let(:order) { create(:order) }
    # let(:product) { create(:product) }


    let(:user) { User.create!(email: "habi11111@gmail.com", password: "123456789", first_name: "habi", last_name: "Pyatha", address: "Thimi", contact_phone: "9876543212") }
    let(:vendor) { Vendor.create!(email: "habi22222@gmail.com", password: "123456789", owner_name: "habi", shop_name: "Pro", address: "thimi", contact_number: "9876543211") }
    let(:category) { ProductCategory.create!(name: "Powerbank12") }
    let(:product) { Product.create!(title: "PowerBank12", brand: "X-age", description: "best for the price", price: "2500", product_category_id: category.id, stock: 100, discount_percentage: 23, vendor_id: vendor.id) }
    let(:order) { Order.create!(user_id: user.id) }
    let(:subject) {
    OrderProduct.new(order_id: order.id, product_id: product.id, quantity: 1)
    # OrderProduct.new(order_id: 11, product_id: 11, quantity: 1)
  }
  it "is valid with valid attributes" do
    # subject.valid?
    expect(subject).to be_valid
  end

  it "is invalid without an order_id" do
    subject.order_id=nil
    expect(subject).not_to be_valid
  end

  it "is invalid without a product_id" do
    subject.product_id=nil
    expect(subject).not_to be_valid
  end

  it "is invalid without a quantity" do
    subject.quantity=nil
    expect(subject).not_to be_valid
  end

  it "is invalid with a quantity less than 1" do
    subject.quantity=0
    # puts "teste #{subject.errors[:quantity]}"
    expect(subject).not_to be_valid
    # expect(subject.errors[:quantity]).to be_valid
  end

  it "is invalid with a non-numeric quantity" do
    subject.quantity="a76c"
    expect(subject).not_to be_valid
  end


  it "has a default status of 'pending'" do
    expect(subject.status).to eq("pending")
  end


  it "can change status to 'on_the_way'" do
    subject.status="on_the_way"
    expect(subject.status).to eq("on_the_way")
  end
  it "can change status to 'shipped'" do
    subject.status="shipped"
    expect(subject.status).to eq("shipped")
  end
  it "can change status to 'cancelled'" do
    subject.status="cancelled"
    expect(subject.status).to eq("cancelled")
  end
end
