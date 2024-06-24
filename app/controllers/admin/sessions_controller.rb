class Admin::SessionsController < Devise::SessionsController
  layout 'admin'

  def create
    super do |resource|
      flash[:notice] = "管理者としてログインしました。"
      redirect_to root_path and return
    end
  end
end
