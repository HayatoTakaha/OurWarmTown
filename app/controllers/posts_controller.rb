class PostsController < ApplicationController
  before_action :set_post, only: [:show, :toggle_like]
  before_action :set_group, only: [:new, :create], if: -> { params[:group_id].present? }
  
  def index
    @posts = Post.all
  end
  
  def new
    @post = @group ? @group.posts.build : Post.new
  end

  def create
    @post = @group ? @group.posts.build(post_params) : Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to @post, notice: '投稿が作成されました。'
    else
      render :new
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def set_group
    @group = Group.find(params[:group_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to groups_path, alert: 'グループが見つかりません。'
  end

  def post_params
    params.require(:post).permit(:title, :content, :group_id, images: [])
  end
end
