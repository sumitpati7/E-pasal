module Api
    module V1
      class ApplicationController < ActionController::Base
        skip_forgery_protection
        respond_to :json
      end
    end
end