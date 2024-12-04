module VendorsHelper
    def vendor_profile_image_or_user_name(vendor, css)
        if vendor.vendor_image.attached?
            image_tag current_vendor.vendor_image, class: "#{css} rounded-full"
        else
            content_tag(:div, vendor.shop_name[0], class: "rounded-full bg-blue-200 capitalize flex justify-center items-center font-bold text-center #{css}")
        end
    end
end
