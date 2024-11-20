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
class VendorSerializer < ActiveModel::Serializer
  attributes :id, :image_url, :shop_name, :address, :contact_number
  has_many :products
end
