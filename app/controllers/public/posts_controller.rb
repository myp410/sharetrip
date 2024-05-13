class Public::PostsController < ApplicationController
  protect_from_forgery
  before_action :authenticate_user!, only: [:new, :show, :create, :edit, :update]
  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    tags = params[:post][:name].split(',')
    if @post.save
      @post.save_tags(tags)
      redirect_to post_path(@post), notice: "新規投稿に成功しました"
    else
      flash.now[:alert] = "投稿の保存に失敗しました。以下の内容を確認してください"
      render 'new'
    end
  end

  def index
    @posts = Post.page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
    @duration = (@post.finish_date - @post.start_date).to_i + 1
    @itinerary = @post.itineraries.build
    @itineraries = @post.itineraries.order(what_day: :asc, start_time: :asc)
    @tags = @post.tags.pluck(:name).join(',')
    @post_tags = @post.tags
    @search_day = params[:search_day]
    @search = @itineraries.where(what_day: @search_day)
  end

  def edit
    is_matching_login_user
    @post = Post.find(params[:id])
    @tags = @post.tags.pluck(:name).join(',') #nameを引き出してくれる
  end

  def update
    is_matching_login_user
    @post = Post.find(params[:id])
    tags = params[:post][:name].split(',')
    if @post.update(post_params)
      @post.update_tags(tags)
      redirect_to post_path(@post), notice: "投稿を更新しました"
    else
      render 'edit' , alert: "投稿の更新に失敗しました"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to posts_path
  end

  def search_tag
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @posts = @tag.posts
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
