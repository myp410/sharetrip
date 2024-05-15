class Public::ArticlesController < ApplicationController
  before_action :authenticate_user!

  def create
    @itinerary = Itinerary.find(params[:itinerary_id])
    @article = Article.new(article_params)
    if @article.save
      redirect_to post_itinerary_path(@itinerary.post_id, @itinerary)
    else
      render 'public/itineraries/show'
    end
  end

  def destroy
    article = Article.find(params[:id])
    itinerary = Itinerary.find(params[:itinerary_id])
    article.destroy
    redirect_to post_itinerary_path(itinerary.post_id, itinerary)
  end

  private

  def article_params
    params.require(:article).permit(:title, :link, :itinerary_id)
  end
end
