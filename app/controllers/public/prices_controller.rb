class Public::PricesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @itinerary = Itinerary.find(params[:itinerary_id])
    @post = @itinerary.post
    @price = Price.new(price_params)
    @price.save
    @prices = @itinerary.prices
  end
  
  def destroy
    @itinerary = Itinerary.find(params[:itinerary_id])
    @post = @itinerary.post
    @price = Price.find(params[:id])
    @price.destroy
    @prices = @itinerary.prices
  end
  
  private
  
  def price_params
    params.require(:price).permit(:price, :body, :itinerary_id)
  end
end
