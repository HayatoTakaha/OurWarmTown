class PostsController < ApplicationController
  before_action :set_post, only: [:show, :toggle_like]

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

  def toggle_like
    retries ||= 0

    ActiveRecord::Base.transaction do
      if current_user.liked?(@post)
        like = current_user.likes.find_by(post_id: @post.id)
        like.destroy!
      else
        @post.likes.create!(user: current_user)
      end
    end

    respond_to do |format|
      format.html { redirect_to @post }
      format.json { render json: { liked: current_user.liked?(@post), likes_count: @post.likes.count } }
    end

  rescue ActiveRecord::StatementInvalid => e
    if e.message.include?('SQLite3::BusyException')
      retries += 1
      if retries < 5
        sleep(0.1 * retries)
        retry
      else
        respond_to do |format|
          format.html { redirect_to @post, alert: 'サービス利用不可です。' }
          format.json { render status: 503, json: { error: 'サービス利用不可です。' } }
        end
      end
    else
      raise
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
