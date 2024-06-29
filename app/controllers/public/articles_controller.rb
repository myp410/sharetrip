class Public::ArticlesController < ApplicationController
  before_action :authenticate_user!

  def create
    @itinerary = Itinerary.find(params[:itinerary_id])
    @post = @itinerary.post
    @article = Article.new(article_params)
    @article.save
    @articles = @itinerary.articles
  end

  def destroy
    @article = Article.find(params[:id])
    @itinerary = Itinerary.find(params[:itinerary_id])
    @post = @itinerary.post
    @article.destroy
    @articles = @itinerary.articles
  end

  private
    def article_params
      params.require(:article).permit(:title, :link, :itinerary_id)
    end
end
