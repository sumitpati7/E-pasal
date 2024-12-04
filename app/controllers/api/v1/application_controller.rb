module Api
    module V1
      class ApplicationController < ActionController::Base
        skip_forgery_protection with: :exception
        respond_to :json

        def authenticate_user!
          token = request.headers["Authorization"]&.split(" ")&.last
          payload = JWT.decode(token, Rails.application.credentials.secret_key_base)[0]
          @current_user = User.find(payload["user_id"])
        rescue JWT::DecodeError, ActiveRecord::RecordNotFound
          render json: { error: "Unauthorized access" }, status: :unauthorized
        end

        def current_user
          @current_user
        end
      end
    end
end
