# == Schema Information
#
# Table name: orders
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Order, type: :model do
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

  let(:order) {
    Order.create!(
      user_id: user.id
    )
  }

  # associations
  describe "associations" do
    it "belongs to a user" do
      expect(order.user).to eq(user)
    end
  end

  describe "validations" do
    it "is valid with valid user id" do
      subject.valid?
      expect(subject.errors[:user_id]).to be_empty
    end

    it "is invalid without user id" do
      subject.user_id = nil
      subject.valid?
      expect(subject.errors[:user]).to include("must exist")
    end

    it "is invalid with invalid user id" do
      subject.user_id = 120
      subject.valid?
      expect(subject.errors[:user]).to include("must exist")
    end
  end
end
