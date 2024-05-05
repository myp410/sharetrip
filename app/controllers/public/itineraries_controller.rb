class Public::ItinerariesController < ApplicationController
  
  
  def show
  end
  
  def create
    @post = Post.find(params[:post_id])
    @itinerary = Itinerary.new(itinerary_params)
    if @itinerary.save
      redirect_to post_path(@itinerary.post_id),notice: "旅程の追加に成功しました"
    else
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
      redirect_to post_path(@itinerary.post_id),notice: "旅程の更新に成功しました"
    else
      flash.now[:alert] = "旅程の更新に失敗しました"
      render 'public/posts/show'
    end  
  end
  
  
  def destroy
  end
  
  def destroy_all
  end
  
  private
  
  def itinerary_params
    params.require(:itinerary).permit(:post_id, :title, :body, :start_time, :finish_time, :place)
  end  
end
