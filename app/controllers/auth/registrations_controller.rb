class Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController

  private

  def sign_up_params
    params.require(:registration).permit(:name, :email, :password, :password_confirmation, :gender, :date_of_birth)
  end
end