class Api::V1::SessionsController < Devise::SessionsController
  
  before_action :sign_in_params, only: [:create]
  # after_action :after_sign_in_path_for, only: [:create]
  respond_to :json
  # before_action :update_token, only: [:destroy]
  def new
    super
  end
  def create
    user = User.find_by(email: params[:user][:email])
    if user.present?
      if user.valid_password?(params[:user][:password])
        data = { msg: "Login Successfull", current_user: {id: user.id, name: user.name, user_name: user.user_name, email: user.email, user_token: user.authentication_token } }
        render status: 200, json: { user_data: data }
      else 
        render status: 400, json: { errors: "Login Fail, Invalid Credentials" }
      end
    else
      render status: 400, json: { errors: "Login Fail, Invalid Credentials" }
    end
  end

  def destroy
    binding.pry
  end
  
  def sign_in_params
    params.require(:user).permit(:email, :password)
  end

  # def after_sign_in_path_for(resource)
  #   flash[:notice] = "Welcome back #{resource.name.split(' ')[0]}"
  #   'localhost:4200'
  # end

  # def update_token
  #   current_user.update(authentication_token: nil) if current_user.present?
  # end
end
