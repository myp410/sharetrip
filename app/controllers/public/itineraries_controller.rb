class Public::ItinerariesController < ApplicationController
  before_action :ensure_correct_user, only: %i[create edit update destroy destroy_all]
  before_action :authenticate_user!

  def show
    @itinerary = Itinerary.find(params[:id])
    @post = Post.find(params[:post_id])
    @duration = (@post.finish_date - @post.start_date).to_i + 1
    @article = Article.new
    @articles = @itinerary.articles
    @price = Price.new
    @prices = @itinerary.prices
    @tags = @post.tags.pluck(:name).join(",")
    @post_tags = @post.tags
  end

  def create
    @post = Post.find(params[:post_id])
    @itinerary = Itinerary.new(itinerary_params)
    @itinerary.post_id = @post.id

    if @itinerary.save
      redirect_to post_path(@post), notice: "旅程の追加に成功しました"
    else
      @itinerary.post_id = nil
      @itineraries = @post.itineraries.page(params[:page])
      @tags = @post.tags.pluck(:name).join(",")
      @duration = (@post.finish_date - @post.start_date).to_i + 1
      @post_tags = @post.tags
      @search_day = params[:search_day]
      @search = @itineraries.where(what_day: @search_day)
      render "public/posts/show"
    end
  end

  def update
    @itinerary = Itinerary.find(params[:id])
    @post = Post.find(params[:post_id])
    if @itinerary.update(itinerary_params)
      redirect_to post_itinerary_path(@post, @itinerary), notice: "旅程の更新に成功しました"
    else
      @duration = (@post.finish_date - @post.start_date).to_i + 1
      @article = Article.new
      @articles = @itinerary.articles
      @price = Price.new
      @prices = @itinerary.prices
      @tags = @post.tags.pluck(:name).join(",")
      @post_tags = @post.tags
      flash.now[:alert] = "旅程の更新に失敗しました"
      render "show"
    end
  end


  def destroy
    itinerary = Itinerary.find(params[:id])
    post = Post.find(params[:post_id])
    itinerary.destroy
    redirect_to post_path(post)
  end

  def destroy_all
    post = Post.find(params[:post_id])
    itineraries = post.itineraries
    itineraries.destroy_all
    redirect_to request.referer, notice: "旅程をすべて削除しました。"
  end

  private
    def itinerary_params
      params.require(:itinerary).permit(:post_id, :title, :body, :start_time, :finish_time, :address, :longitude, :latitude, :what_day, :traffic_method, :traffic_time_hour, :traffic_time_min)
    end

    def ensure_correct_user
      post = Post.find(params[:post_id])
      user = post.user
      return if user == current_user # trueならここで処理を終了
      redirect_to posts_path # falseならこの処理になる
    end
end
