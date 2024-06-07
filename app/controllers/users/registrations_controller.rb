# app/controllers/users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    mypage_users_path
  end

  def after_update_path_for(resource)
    mypage_users_path
  end
end
