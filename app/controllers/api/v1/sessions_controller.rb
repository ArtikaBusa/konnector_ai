module Api
  module V1
    class SessionsController < ActionController::API
      before_action { request.format = :json }

      def create
        user = User.find_by(email: params[:email])

        if user&.valid_password?(params[:password])
          render json: {
            token: user.authentication_token,
            role: user.role
          }, status: :ok
        else
          render json: { error: "Invalid credentials" }, status: :unauthorized
        end
      end
    end
  end
end
