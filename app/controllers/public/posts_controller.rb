class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post), notice: "新規投稿に成功しました"
    else
      flash.now[:alert] = "投稿の保存に失敗しました。以下の内容を確認してください"
      render 'new'
    end  
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @new_itinerary = Itinerary.new
    @itineraries = Itinerary.order(start_time: :asc)
  end

  def edit
    is_matching_login_user
    @post = Post.find(params[:id])
  end
  
  def update
    is_matching_login_user
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "投稿を更新しました"
    else 
      render 'edit' , alert: "投稿の更新に失敗しました"
    end  
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  
  private
  
  def post_params
    params.require(:post).permit(:title, :body, :start_date, :finish_date, :status)
  end

  
  def is_matching_login_user
    post = Post.find(params[:id])
    user = post.user
    return if user == current_user
    redirect_to posts_path
  end
  
end
