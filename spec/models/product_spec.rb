# == Schema Information
#
# Table name: products
#
#  id                  :bigint           not null, primary key
#  title               :string           not null
#  brand               :string           default("No Brand"), not null
#  description         :text
#  price               :string           not null
#  product_category_id :bigint           not null
#  stock               :integer          not null
#  discount_percentage :integer          default(0), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  vendor_id           :bigint           not null
#  image_url           :string
#
require 'rails_helper'

RSpec.describe Product, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  subject { Product.new(brand: "Sunsilk", description: "Hello World", price: 350, stock: 12, discount_percentage: 12, product_category_id: 26, vendor_id: 26) }


  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is valid with a title" do
    subject.valid?
    expect(subject.errors[:title]).to be_empty
  end

  it "is invalid without a title" do
    subject.title = nil
    subject.valid?
    expect(subject.errors[:title]).to include("can't be blank")
  end

  it "is invalid without a price" do
    subject.price = nil
    subject.valid?
    expect(subject.errors[:price]).to include("can't be blank")
  end

  it "is invalid with discount percentage more than 100" do
    subject.discount_percentage = 200
    subject.valid?
    expect(subject.errors[:discount_percentage]).to include("must be less than 100")
  end

  it "is invalid with string discount percentage" do
    subject.discount_percentage = "12a"
    subject.valid?
    expect(subject.errors[:discount_percentage]).to include("is not a number")
  end

  it "is invalid with stock less than 0" do
    subject.stock= -5
    subject.valid?
    expect(subject.errors[:stock]).to include("must be greater than or equal to 1")
  end

  it "is invalid if vendor_id is null" do
    subject.vendor_id = nil
    expect(subject).not_to be_valid
  end
end
