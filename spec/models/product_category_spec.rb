# == Schema Information
#
# Table name: product_categories
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  icon       :string
#
require 'rails_helper'

RSpec.describe ProductCategory, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  subject {
    ProductCategory.new(name: "Watches", icon: "fa-watch")
  }

  it "is valid with valid params" do
    subject.name = "Clothing"
    expect(subject).to be_valid
  end

  it "is invalid with no name" do
    subject.name = nil
    subject.valid?
    expect(subject.errors[:name]).to include("can't be blank")
  end

  it "is invalid without unique name" do
    subject.name="Beauty"
    subject.valid?
    expect(subject.errors[:name]).to include("has already been taken")
  end
end
