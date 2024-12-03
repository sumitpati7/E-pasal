# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  content    :text
#  user_id    :bigint           not null
#  product_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:category) {
    ProductCategory.create!(name: "Powerbank12345")
  }

  let(:vendor) {
    Vendor.create!(
      email: "habi2221232@gmail.com",
      password: "123456789",
      owner_name: "habi",
      shop_name: "Pro",
      address: "thimi",
      contact_number: "9876543211")
    }

  let(:user) {
    User.create!(
      first_name: "Sanford",
      middle_name: "Mc",
      last_name: "Gregor",
      email: "sanford@mcgregor.com",
      password: "sanfordmcgregor",
      address: "somewhere",
      contact_phone: "9876543210",
    )
  }

  let(:product) {
    Product.create!(
      title: "sunsilk shampoo",
      brand: "Sunsilk",
      description: "Hello World",
      price: 350,
      stock: 12,
      discount_percentage: 12,
      product_category_id: category.id,
      vendor_id: vendor.id
    )
  }

  let(:valid_comment) {
    Comment.new(
      content: "Great product!",
      user_id: user.id,
      product_id: product.id
    )
  }

  # associations
  describe 'associations' do
    it "belongs to a user" do
      expect(valid_comment.user).to eq(user)
    end

    it "belongs to a product" do
      expect(valid_comment.product).to eq(product)
    end
  end

  # validations
  describe "validations" do
    it "is valid with valid attributes" do
      expect(valid_comment).to be_valid
    end

    it "is invalid without user" do
      valid_comment.user = nil
      valid_comment.valid?
      expect(valid_comment.errors[:user]).to include("must exist")
    end

    it "is invalid without product" do
      valid_comment.product = nil
      valid_comment.valid?
      expect(valid_comment.errors[:product]).to include("must exist")
    end

    it "is invalid without a content" do
      valid_comment.content = nil
      valid_comment.valid?
      expect(valid_comment.errors[:content]).to include("can't be blank")
    end
  end
end
