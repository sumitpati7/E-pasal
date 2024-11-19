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
class UserSerializer < ActiveModel::Serializer
    attributes :id, :first_name, :middle_name, :last_name, :full_name, :address, :contact_phone

    def full_name
        if object.middle_name.nil?
            object.first_name+" "+object.last_name
        else
            object.first_name+" "+object.middle_name+" "+object.last_name
        end
    end
end
