# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  first_name             :string
#  middle_name            :string
#  last_name              :string
#  address                :text
#  contact_phone          :string
#
require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(
      first_name: "Sanford",
      middle_name: "Mc",
      last_name: "Gregor",
      email: "sanford@mcgregor.com",
      password: "sanfordmcgregor",
      address: "somewhere",
      contact_phone: "9876543210",
    )
  }

  # ****Negative tests*****
  it "is invalid without first name" do
    subject.first_name = nil
    subject.valid?
    expect(subject.errors[:first_name]).to include("can't be blank")
  end

  it "is invalid without last name" do
    subject.last_name = nil
    subject.valid?
    expect(subject.errors[:last_name]).to include("can't be blank")
  end

  it "is invalid without email" do
    subject.email = nil
    subject.valid?
    expect(subject.errors[:email]).to include("can't be blank")
  end

  it "is invalid without password" do
    subject.password = nil
    subject.valid?
    expect(subject.errors[:password]).to include("can't be blank")
  end

  it "is invalid without address" do
    subject.address = nil
    subject.valid?
    expect(subject.errors[:address]).to include("can't be blank")
  end

  it "is invalid without contact phone" do
    subject.contact_phone = nil
    subject.valid?
    expect(subject.errors[:contact_phone]).to include("can't be blank")
  end

  it "is invalid with a duplicate email" do
    User.create!(
      first_name: "Sanford",
      middle_name: "Mc",
      last_name: "Gregor",
      email: "sanford@mcgregor.com",
      password: "sanfordmcgregor",
      address: "somewhere",
      contact_phone: 9876543210,
    )
    duplicate_user = subject.dup
    expect(duplicate_user).to_not be_valid
    expect(duplicate_user.errors[:email]).to include("has already been taken")
  end

  it "is invalid if password is less than 6 characters" do
    subject.password = "12345"
    subject.valid?
    expect(subject.errors[:password]).to include("is too short (minimum is 6 characters)")
  end

  it "is invalid if email is of improper format" do
    subject.email = "invalid_email"
    subject.valid?
    expect(subject.errors[:email]).to include("is invalid")
  end

  it "is invalid if phone number does not start with 98 or 97 and is not 10 digit" do
    subject.contact_phone = "98aaa0#236"
    subject.valid?
    expect(subject.errors[:contact_phone]).to include("Invalid phone number")
  end

  it "is invalid if phone number contains text or special character" do
    subject.contact_phone = "98aaa0#236"
    subject.valid?
    expect(subject.errors[:contact_phone]).to include("Invalid phone number")
  end

  # *****Positive tests****

  it "is valid with valid attributes" do
    subject.valid?
    expect(subject).to be_valid
  end

  it "is valid with valid first name" do
    subject.first_name = "Ahyeon"
    subject.valid?
    expect(subject.errors[:first_name]).to be_empty
  end

  it "is valid with valid last name" do
    subject.last_name = "Jung"
    subject.valid?
    expect(subject.errors[:last_name]).to be_empty
  end

  it "is valid with valid email" do
    subject.email = "ahyeon@gmail.com"
    subject.valid?
    expect(subject.errors[:email]).to be_empty
  end

  it "is valid with password with 6 or more characters" do
    subject.password = "jungahyeon"
    subject.valid?
    expect(subject.errors[:password]).to be_empty
  end

  it "is valid with valid address" do
    subject.address = "seoul"
    subject.valid?
    expect(subject.errors[:address]).to be_empty
  end

  it "is valid with valid contact number" do
    subject.contact_phone = "9876543210"
    subject.valid?
    expect(subject.errors[:contact_phone]).to be_empty
  end
end
