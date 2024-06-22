class Admin::SessionsController < Devise::SessionsController
  layout 'admin'

  def create
    super do |resource|
      flash[:notice] = "管理者としてログインしました。"
      redirect_to admin_users_path and return
    end
  end
end
