class PostsController < ApplicationController
  before_action :set_post, only: [:show, :toggle_like]
  
  def index
    @posts = Post.all
  end
  
  def new
    @group = Group.find(params[:group_id])
    @post = @group.posts.build
  end

  def create
    @group = Group.find(post_params[:group_id])
    @post = @group.posts.build(post_params)
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

  def post_params
    params.require(:post).permit(:title, :content, :group_id, images: [])
  end
end
