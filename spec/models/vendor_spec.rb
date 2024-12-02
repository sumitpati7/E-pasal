# == Schema Information
#
# Table name: vendors
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  owner_name             :string
#  shop_name              :string
#  address                :text
#  contact_number         :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
require 'rails_helper'

RSpec.describe Vendor, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  subject { Vendor.new(email: "habi@gmail.com", password: "1234habipyataha", owner_name: "Habi", shop_name: "PyathaShop", address: "Madhyapur Thimi", contact_number: "98413001454") }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
  # it "is is not without email" do
  #   subject.email=nil
  #   expect(subject).to_not be_valid
  # end

  it "is invalid email" do
    email=Vendor.new(email: "ramsita")
    email.valid?
    expect(email.errors[:email]).to include("is invalid")
  end


  it "is invalid without an email" do
    vendor=Vendor.new(email: nil)
    vendor.valid?
    expect(vendor.errors[:email]).to include("can't be blank")
  end
  it "is invalid with a duplicate email address" do
    Vendor.create!(
      email: "habi@gmail.com", password: "12345678", owner_name: "Habi", shop_name: "ProShop", address: "Thimi", contact_number: "9876545676"
    )
    vendor=Vendor.new(
      email: "habi@gmail.com", password: "12345678", owner_name: "Habi", shop_name: "ProShop", address: "Thimi", contact_number: "987654567678787"
    )
    vendor.valid?
    expect(vendor.errors[:email]).to include("has already been taken")
  end

  it "is not valid without a password" do
    subject.password=nil
    expect(subject).to_not be_valid
    # subject.valid?
    # expect(subject.errors[:password]).to include("can't be blank")
  end
  it "is not valid if the password is less than 6 chars" do
    subject.password="12345"
    expect(subject).to_not be_valid
    # puts subject.password
    # subject.valid?
    # expect(subject.errors[:password]).to include("is too short (minimum is 6 characters)")
  end

  it "is valid if password is equal and greater than 6 char" do
    subject.valid?
    expect(subject.errors[:password]).to be_empty
  end
  # it "is valid if password is equal and greater than 6 char" do
  #   subject.password="56745678jdf"
  #   # expect(subject.errors[:password]).to be_empty
  #   expect(subject).to be_valid
  # end  This is the ways

  it "is not valid without an Owner name" do
    subject.owner_name=nil
    expect(subject).to_not be_valid
    # subject.valid?
    # expect(subject.errors[:owner_name]).to include("can't be blank")
  end

  it "is not valid without an Shop name" do
    subject.shop_name=nil
    expect(subject).to_not be_valid
    # expect(subject.errors[:shop_name]).to include("can't be blank")
  end

  it "is not valid without a phone number" do
    subject.contact_number=nil
    expect(subject).to_not be_valid
    # subject.valid?
    # expect(subject.errors[:contact_number]).to include("can't be blank")
  end

  it "is not valid without an address" do
    subject.address= nil
    expect(subject).to_not be_valid
    # subject.valid?
    # expect(subject.errors[:address]).to include("can't be blank")
  end

  it "is not valid if the phone number is not 10 chars" do
    subject.contact_number="987654"
    expect(subject).to_not be_valid
    # subject.valid?
    # expect(subject.errors[:contact_number]).to include("Invalid phone number")
  end

  it "is not valid if the phone number is not all digits" do
    subject.contact_number="9876543asd"
    expect(subject).to_not be_valid
    # subject.valid?
    # expect(subject.errors[:contact_number]).to include("Invalid phone number")
  end
end
