class GroupsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_group, only: [:show, :edit, :update, :destroy, :join, :leave]
  before_action :ensure_owner_or_admin, only: [:edit, :update, :destroy]
  before_action :ensure_admin, only: [:manage]

  def index
    @groups = Group.all
  end

  def show
    if user_signed_in?
      @is_owner = current_user == @group.owner
      @is_member = @group.users.exists?(current_user.id)
    else
      @is_owner = false
      @is_member = false
    end
    @group_posts = @group.posts.order(created_at: :desc).page(params[:page])
  end

  def new
    @group = current_user.owned_groups.build
  end

  def create
    @group = Group.new(group_params)
    @group.owner = current_user
    if @group.save
      redirect_to @group, notice: 'グループが作成されました。'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to @group, notice: 'グループが更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    redirect_to root_path, notice: 'グループが削除されました。'
  end

  def join
    unless @group.users.include?(current_user)
      @group.user_groups.create(user: current_user, joined_at: Time.current)
      redirect_to @group, notice: 'グループに参加しました。'
    end
  end

  def leave
    if @group.users.include?(current_user)
      @group.users.delete(current_user)
      redirect_to @group, notice: 'グループから外れました。'
    end
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def ensure_owner_or_admin
    unless @group.owner == current_user || current_user.admin?
      redirect_to groups_path, alert: 'グループを編集する権限がありません。'
    end
  end

  def ensure_admin
    unless current_user.admin?
      redirect_to root_path, alert: '管理者権限が必要です。'
    end
  end

  def group_params
    params.require(:group).permit(:name, :description, :image)
  end
end
