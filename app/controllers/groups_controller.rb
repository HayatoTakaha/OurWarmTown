class GroupsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_group, only: [:show, :edit, :update, :destroy, :join, :leave]
  before_action :ensure_owner, only: [:edit, :update, :destroy]
  before_action :ensure_admin, only: [:manage]

  def index
    @groups = Group.all
  end

  def show
    @group_posts = @group.posts.order(created_at: :desc).page(params[:page]).per(6)
    @is_owner = @group.owner == current_user
    @is_member = @group.users.include?(current_user)
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
    redirect_to groups_url, notice: 'グループが削除されました。'
  end

  def join
    unless @group.users.include?(current_user)
      @group.users << current_user
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

  def ensure_owner
    unless @group.owner == current_user
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
