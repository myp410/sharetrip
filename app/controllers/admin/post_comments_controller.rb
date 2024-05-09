class Admin::PostCommentsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @post = Post.find(params[:post_id])
    @post_comments = @post.post_comments
  end
  
  def destroy
    post_comment = PostComment.find(params[:id])
    post_comment.destroy
    redirect_to admin_post_post_comments_path, notice: "コメントの削除に成功しました"
  end  
end
