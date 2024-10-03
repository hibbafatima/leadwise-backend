# frozen_string_literal: true

# sessions_controller.rb

module Api
  class SessionsController < ApplicationController
    def create
      @user = User.find_by(email: session_params[:email])

      if @user && @user.password == (session_params[:password])
        login!
        render json: {
          logged_in: true,
          user: @user
        }
      else
        render json: {
          status: 401,
          errors: ['no such user, please try again']
        }
      end
    end

    def is_logged_in?
      if logged_in? && current_user
        render json: {
          logged_in: true,
          user: current_user
        }
      else
        render json: {
          logged_in: false,
          message: 'no such user'
        }
      end
    end

    def destroy
      logout!
      render json: {
        status: 200,
        logged_out: true
      }
    end

    private

    def session_params
      params.require(:session).permit(:email, :password)
    end
  end
end
