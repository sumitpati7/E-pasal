module Api
    module V1
      class ApplicationController < ActionController::Base
        skip_forgery_protection with: :exception
        respond_to :json
      end
    end
end