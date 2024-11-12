class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def after_sign_in_path_for(resource)
    vendor_path(current_vendor.id)
  end
  def after_sign_out_path_for(resource)
    new_vendor_session_path
  end
end
