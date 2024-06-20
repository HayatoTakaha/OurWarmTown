class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy, :toggle_like]
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

  def toggle_like
    retries = 0
    begin
      ActiveRecord::Base.transaction do
        @like = current_user.likes.find_by(post: @post)
        if @like
          @like.destroy!
        else
          current_user.likes.create!(post: @post)
        end
      end
      render json: { liked: current_user.liked?(@post), likes_count: @post.likes.count }
    rescue ActiveRecord::StatementInvalid => e
      if e.message.include?("database is locked")
        retries += 1
        if retries <= 3
          sleep 0.2
          retry
        else
          render json: { error: 'Database is locked. Please try again later.' }, status: :service_unavailable
        end
      else
        render json: { error: 'An unexpected error occurred.' }, status: :internal_server_error
      end
    end
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
