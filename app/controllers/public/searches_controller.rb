class Public::SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
    @model = params[:model]
    @word = params[:word]
    
    if @model == "User"
      @users = User.looks(params[:word]).page(params[:page])
    elsif @model == "Post"
      @posts = Post.looks(params[:word]).page(params[:page])
    else  
    # elsif @model == "Itinerary"
      @itineraries = Itinerary.looks(params[:word]).page(params[:page])
      # @post_comment = PostComment.looks(params[:word])
    end
  end  
      
end
