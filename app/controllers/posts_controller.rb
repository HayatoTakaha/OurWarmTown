class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search, :search_results]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
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
    redirect_to posts_path, notice: '投稿が削除されました。'
  end

  def search
  end

  def search_results
    @posts = Post.where('title LIKE ? OR content LIKE ?', "%#{params[:q]}%", "%#{params[:q]}%")
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to posts_path, notice: '権限がありません。' if @post.nil?
  end
end
