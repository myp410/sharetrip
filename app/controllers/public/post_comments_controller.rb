class Public::PostCommentsController < ApplicationController
  before_action :authenticate_user!
  def index
    @post = Post.find(params[:post_id])
    @new_comment = PostComment.new
    @post_tags = @post.tags
    @post_comments = @post.post_comments.order(created_at: :desc).page(params[:page]).per(4)
  end

  def create
    @post = Post.find(params[:post_id])
    @new_comment = current_user.post_comments.new(post_comment_params)
    @new_comment.post_id = @post.id
    @new_comment.save
    @post_comments = @post.post_comments.order(created_at: :desc).page(params[:page]).per(4)
  end

  def edit
    @post = Post.find(params[:post_id])
    @post_tags = @post.tags
    @post_comment = PostComment.find(params[:id])
  end

  def update
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.find(params[:id])
    if @post_comment.update(post_comment_params)
      flash[:notice] =  "コメントの更新に成功しました"
      redirect_to post_post_comments_path(@post)
    else
      @post_tags = @post.tags
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.find(params[:id])
    @post_comment.destroy
    @post_comments = @post.post_comments.page(params[:page])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment, :post_id, :user_id)
  end
end
