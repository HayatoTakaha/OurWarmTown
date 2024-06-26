class PostsController < ApplicationController
  before_action :set_post, only: [:show, :toggle_like]
  before_action :set_group, only: [:new, :create]
  before_action :authenticate_user!

  def index
    @posts = current_user.posts.order(created_at: :desc).page(params[:page]).per(8)
  end
  
  def show
  end

  def new
    @post = @group ? @group.posts.build : Post.new
  end

  def create
    @post = @group ? @group.posts.build(post_params) : Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to @group ? group_path(@group) : post_path(@post), notice: '投稿が作成されました。'
    else
      render :new
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def set_group
    @group = Group.find(params[:group_id]) if params[:group_id].present?
  rescue ActiveRecord::RecordNotFound
    @group = nil
    redirect_to groups_path, alert: 'グループが見つかりません。' if params[:group_id].present?
  end

  def post_params
    params.require(:post).permit(:title, :content, :group_id, images: [])
  end
end
