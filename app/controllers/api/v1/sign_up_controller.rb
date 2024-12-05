module Api
    module V1
      class SignUpController < Api::V1::ApplicationController
        def create
          user =  User.new(user_params)
          if user.save
            token = generate_jwt(user)
            render json: { token: token, message: "User Registered Successfully", user: UserSerializer.new(user).as_json }, status: :created
          else
            render json: { "error": user.errors.full_messages }, status: :unprocessable_entity
          end
        end

        private
        def user_params
            params.permit(:email, :password, :first_name, :middle_name, :last_name, :address, :contact_phone, :user_image)
        end

        def generate_jwt(user)
          payload = { user_id: user.id, exp: 24.minutes.from_now.to_i }
          JWT.encode(payload, Rails.application.credentials.secret_key_base)
        end
      end
    end
end
