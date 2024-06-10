class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :set_group, only: [:new, :create]

  def index
    if params[:group_id]
      @group = Group.find(params[:group_id])
      @posts = @group.posts
    else
      @posts = Post.all
    end
  end

  def show
  end

  def new
    @post = current_user.posts.build
    @post.group = @group if @group
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.group = @group if @group

    if @post.save
      redirect_to @post, notice: '投稿が作成されました。'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: '投稿が更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: '投稿が削除されました。'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def set_group
    @group = Group.find(params[:group_id]) if params[:group_id]
  end

  def post_params
    params.require(:post).permit(:title, :content, :group_id, images: [])
  end
end
