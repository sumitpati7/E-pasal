# == Schema Information
#
# Table name: product_categories
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  icon       :string
#
require 'rails_helper'

RSpec.describe ProductCategory, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
