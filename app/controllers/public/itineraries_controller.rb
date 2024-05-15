class Public::ItinerariesController < ApplicationController
  before_action :ensure_correct_user, only: %i[create edit update destroy destroy_all]
  before_action :authenticate_user!
  
  def show
    @itinerary = Itinerary.find(params[:id])
    @post = Post.find(params[:post_id])
    @article = Article.new
    @articles = @itinerary.articles
  end
  
  def create
    @post = Post.find(params[:post_id])
    @itinerary = Itinerary.new(itinerary_params)
    if @itinerary.save
      redirect_to post_path(@itinerary.post_id),notice: "旅程の追加に成功しました"
    else
      @itineraries = Itinerary.order(start_time: :asc)
      flash.now[:alert] = "旅程の追加に失敗しました"
      render 'public/posts/show'
    end  
  end

  def edit
    @itinerary = Itinerary.find(params[:id])
    @post = Post.find(params[:post_id])
  end
  
  def update
    @itinerary = Itinerary.find(params[:id])
    @post = Post.find(params[:post_id])
    if @itinerary.update(itinerary_params)
      redirect_to post_itinerary_path(@itinerary),notice: "旅程の更新に成功しました"
    else
      flash.now[:alert] = "旅程の更新に失敗しました"
      render 'edit'
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
    params.require(:itinerary).permit(:post_id, :title, :body, :start_time, :finish_time, :place, :what_day)
  end  
  
  def ensure_correct_user
    post = Post.find(params[:post_id])
    user = post.user
    return if user == current_user #trueならここで処理を終了
    redirect_to posts_path #falseならこの処理になる
  end
end
