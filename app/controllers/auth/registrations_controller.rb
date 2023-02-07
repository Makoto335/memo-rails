class Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController

  private

  def sign_up_params
    params.require(:registration).permit(:name, :email, :password, :password_confirmation, :date_of_birth, :avatar)
  end
end