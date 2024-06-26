class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:edit, :show, :update, :destroy, :liked_posts]

  def mypage
    @user = current_user
    @posts = @user.posts.page(params[:page])
  end
  
  def index
    @posts = @user.posts.order(created_at: :desc).page(params[:page]).per(8)
  end
  
  def edit
  end

  def show
    @posts = @user.posts.order(created_at: :desc).limit(3)
  end

  def update
    if @user.update(user_params)
      redirect_to mypage_users_path, notice: 'ユーザー情報が更新されました'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path, notice: 'ユーザーが削除されました'
  end

  def liked_posts
    @liked_posts = @user.liked_posts.page(params[:page])
  end

  def search
  end

  def search_results
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
    unless @user
      redirect_to root_path, alert: "ユーザーが見つかりませんでした。"
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile_image)
  end
end
