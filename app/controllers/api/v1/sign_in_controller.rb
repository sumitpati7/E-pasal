module Api
    module V1
      class SignInController < Api::V1::ApplicationController
        def create
            user =  User.find_by(email: params[:email])
            if user.nil?
                render json: {message: "Email not found"}, status: :not_found
            else
                if user&.valid_password?(params[:password])
                    render json: {
                      message: "User Login Successful",
                      user: UserSerializer.new(user).as_json
                    }
                else
                    render json: {"error": "Incorrect Password"}, status: :unprocessable_entity
                end
            end
          end
  
          private
          def login_params
              params.permit(:email, :password)
          end
      end
    end
end
