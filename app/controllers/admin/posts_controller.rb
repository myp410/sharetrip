class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @posts = Post.order(create_at: :desc)
  end
  
  def show
    @post = Post.find(params[:id])
    @itineraries = @post.itineraries.order(start_time: :asc)
  end  

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path, notice: "該当の投稿を削除しました"
  end
end
