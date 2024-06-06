class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show, :search, :search_results]
  before_action :set_user, only: [:show, :edit, :update, :destroy, :liked_posts]

  def mypage
    @user = current_user
    @posts = @user.posts
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to mypage_users_path, notice: 'プロフィールを更新しました。'
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    @user.destroy
    redirect_to root_path, notice: 'ユーザーアカウントを削除しました。'
  end

  def liked_posts
    @liked_posts = @user.liked_posts
  end

  def search
  end

  def search_results
    @users = User.where('name LIKE ?', "%#{params[:q]}%")
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
