
class ApplicationController < ActionController::Base
    # protect_from_forgery with: :exception, prepend: true
    skip_before_action :verify_authenticity_token
    # before_action :authenticate_user!
    
    rescue_from CanCan::AccessDenied do |exception|
        respond_to do |format|
            format.html { redirect_to root_url, alert: 'You don\'t have access to this resource' }
            format.json { render json: { error: 'Access Denied' }, status: :unauthorized }
        end
    end
end
