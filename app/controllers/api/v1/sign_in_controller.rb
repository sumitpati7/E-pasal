module Api
    module V1
      class SignInController < Api::V1::ApplicationController
        def create
            user = User.find_by(email: params[:email])
            if user&.valid_password?(params[:password])
                token = generate_jwt(user)
                render json: { token: token, message: "User Login Successful", user: UserSerializer.new(user).as_json }, status: :ok
            else
                render json: { error: "Invalid email or password" }, status: :unauthorized
            end
          end

          def destroy
            render json: { message: "Sign Out successfull" }, status: :ok
          end

          private
          def login_params
              params.permit(:email, :password)
          end

          def generate_jwt(user)
            payload = { user_id: user.id, exp: 24.hours.from_now.to_i }
            JWT.encode(payload, Rails.application.credentials.secret_key_base)
          end
      end
    end
end
