
class Api::V1::ApplicationController < ApplicationController
    respond_to :json
    # skip_before_action :verify_authenticity_token
    before_action :authenticate_user

    private
    def authenticate_user
			if request.headers['X-User-Token'].present?
        @current_user = User.find_by(authentication_token: request.headers['X-User-Token'])
        if @current_user.blank?
          render json: { errors: 'Invalid User Token' }, status: :bad_request
          return
        end
      else
        render json: { errors: 'User Token required' }, status: :bad_request
      end
    end
end
