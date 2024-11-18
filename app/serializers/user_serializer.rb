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