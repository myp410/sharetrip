class Public::PostsController < ApplicationController
  protect_from_forgery
  before_action :authenticate_user!, only: [:new, :show, :create, :edit, :update]
  before_action :check_access, only: [:show]

  def create
    @post = current_user.posts.new(post_params)
    tags = params[:post][:name].split(',')

    if params[:post][:status] == "draft"
      @post.status = :draft
    else
      @post.status = :published
    end

    if @post.save
      @post.save_tags(tags)
      if @post.draft?
        redirect_to users_my_page_path(current_user), notice: "下書きが保存されました"
      else
        redirect_to post_path(@post), notice: "投稿が公開されました"
      end
    else
      @post = Post.new
      @posts = Post.published.includes(user: { profile_image_attachment: [:blob] }).includes(:tags).includes(:favorites).order(created_at: :desc).page(params[:page])
      render 'index'
    end
  end

  def index
    # @posts = Post.published.order(created_at: :desc).page(params[:page])
    @post = Post.new
    @posts = Post.published.includes(user: { profile_image_attachment: [:blob] }).includes(:tags).includes(:favorites).order(created_at: :desc).page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
    @duration = (@post.finish_date - @post.start_date).to_i + 1
    @itinerary = Itinerary.new
    @itineraries = @post.itineraries.order(what_day: :asc, start_time: :asc).page(params[:page])
    @tags = @post.tags.pluck(:name).join(',')
    @post_tags = @post.tags
    @search_day = params[:search_day]
    @search = @itineraries.where(what_day: @search_day)
  end

  def update
    is_matching_login_user
    @post = Post.find(params[:id])
    tags = params[:post][:name].split(',')

    if params[:post][:status] == "draft"
      @post.status = :draft
      notice_message = "下書きを保存しました。"
    elsif params[:post][:status] == ":unpublished"
      @post.status = :unpublished
      notice_message = "非公開にしました。"
    else
      @post.status = :published
      notice_message = "投稿を更新しました。"
    end

    if @post.update(post_params)
      @post.update_tags(tags)
      redirect_to post_path(@post), notice: notice_message
    else
      @duration = (@post.finish_date - @post.start_date).to_i + 1
      @itinerary = Itinerary.new
      @itineraries = @post.itineraries.order(what_day: :asc, start_time: :asc).page(params[:page])
      @tags = @post.tags.pluck(:name).join(',')
      @post_tags = @post.tags
      @search_day = params[:search_day]
      @search = @itineraries.where(what_day: @search_day)
      render 'show'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to users_my_page_path(@post.user)
  end

  def search_tag
    @tag_list = Tag.page(params[:page])
    @tag = Tag.find(params[:tag_id])
    @posts = @tag.posts.published.page(params[:page])
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :start_date, :finish_date, :status)
  end


  def is_matching_login_user
    post = Post.find(params[:id])
    user = post.user
    return if user == current_user
    redirect_to users_my_page_path(current_user), alert: "このページにアクセスする権限がありません"
  end

  def check_access
    if @post && (@post.status.draft || @post.status.unpublished)
      if current_user != @post.user
        redirect_to root_path, alert: "このページにアクセスする権限がありません"
        return
      end
    end
  end

end
