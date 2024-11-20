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
class Vendor < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :products
  has_one_attached :vendor_image

  has_many :order_products, through: :products

  def image_url
    # vendor_image.map { |image| Rails.application.routes.url_helpers.rails_blob_url(image, only_path: true) }
    if vendor_image.attached?
      "http://localhost:3001"+  Rails.application.routes.url_helpers.rails_blob_url(vendor_image, only_path: true)
    else
      ""
    end
  end
end
