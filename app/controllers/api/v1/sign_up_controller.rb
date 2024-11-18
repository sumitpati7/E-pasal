module Api
    module V1
      class SignUpController < Api::V1::ApplicationController
        def create
          user =  User.new(user_params)
          if user.save
            render json: {message: "User Registered Successfully", user: user}, status: :created
          else
            render json: {"error": user.errors.full_messages}, status: :unprocessable_entity
          end
        end

        private
        def user_params
            params.permit(:email, :password, :first_name, :middle_name, :last_name, :address, :contact_phone, :user_image)
        end
      end
    end
end