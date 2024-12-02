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
  subject {
    Order.new(
      user_id: 1
    )
  }

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
