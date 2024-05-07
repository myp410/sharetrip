class Public::PostCommentsController < ApplicationController
  def index
    @post = Post.find(params[:post_id])
    @post_comments = @post.post_comments
    @new_comment = PostComment.new
  end
  
  def create
    post = Post.find(params[:post_id])
    new_comment = current_user.post_comments.new(post_comment_params)
    new_comment.post_id = post.id
    if new_comment.save
      redirect_to post_post_comments_path(post),notice: "コメントの投稿に成功しました"
    else
      flash.now[:alert] = "コメントの投稿に失敗しました"
      render 'index'
    end  
  end

  def edit
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.find(params[:id])
  end
  
  def update
    post = Post.find(params[:post_id])
    post_comment = PostComment.find(params[:id])
    if post_comment.update(post_comment_params)
      redirect_to post_post_comments_path(post),notice: "コメントの更新に成功しました"
    else
      flash.now[:alert] = "コメントの更新に失敗しました"
      render 'edit'
    end  
  end
  
  def destroy
    post = Post.find(params[:post_id])
    post_comment = PostComment.find(params[:id])
    post_comment.destroy
    flash[:notice] = "コメントを削除しました"
    redirect_to post_post_comments_path(post)
  end
  
  private
  
  def post_comment_params
    params.require(:post_comment).permit(:comment, :post_id, :user_id)
  end  
end
