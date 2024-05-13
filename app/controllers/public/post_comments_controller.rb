class Public::PostCommentsController < ApplicationController
  before_action :authenticate_user!
  def index
    @post = Post.find(params[:post_id])
    @post_comments = @post.post_comments.page(params[:page])
    @new_comment = PostComment.new
    @post_tags = @post.tags
  end

  def create
    @post = Post.find(params[:post_id])
    @new_comment = current_user.post_comments.new(post_comment_params)
    @new_comment.post_id = @post.id
    @new_comment.save
  end

  def edit
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.find(params[:id])
  end

  def update
    post_comment = PostComment.find(params[:id])
    if post_comment.update(post_comment_params)
      flash[:notice] =  "コメントの更新に成功しました"
    else
      flash.now[:alert] = "コメントの更新に失敗しました"
      render 'edit'
    end
  end

  def destroy
    @post_comment = PostComment.find(params[:id])
    @post_comment.destroy
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment, :post_id, :user_id)
  end
end
