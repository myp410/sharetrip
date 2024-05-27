class Public::PostsController < ApplicationController
  protect_from_forgery
  before_action :authenticate_user!, only: [:new, :show, :create, :edit, :update]
  before_action :check_access, only: [:show]
  def new
    @post = Post.new
  end

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
      render 'new'
    end
  end

  def index
    # @posts = Post.published.order(created_at: :desc).page(params[:page])
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

  def edit
    is_matching_login_user
    @post = Post.find(params[:id])
    @tags = @post.tags.pluck(:name).join(',') #nameを引き出してくれる
  end

  def update
    is_matching_login_user
    @post = Post.find(params[:id])
    tags = params[:post][:name].split(',')

    if params[:post][:status] == "draft"
      @post.status = :draft
      notice_message = "下書きを保存しました。"
      redirect_path = dashboard_posts_path
    elsif params[:post][:status] == ":unpublished"
      @post.status = :unpublished
      notice_message = "非公開にしました。"
      redirect_path = dashboard_posts_path
    else
      @post.status = :published
      notice_message = "投稿を更新しました。"
      redirect_path = post_path(@post)
    end

    if @post.update(post_params)
      @post.update_tags(tags)
      redirect_to redirect_path, notice: notice_message
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to posts_path
  end

  def search_tag
    @tag_list = Tag.page(params[:page])
    @tag = Tag.find(params[:tag_id])
    @posts = @tag.posts.page(params[:page])
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

  def check_access
    if @post && (@post.status.draft || @post.status.unpublished)
      if current_user != @post.user
        redirect_to root_path, alert: "このページにアクセスする権限がありません"
        return
      end
    end
  end

end
