class Public::SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
    @model = params[:model]
    @word = params[:word]
    
    if @model == "User"
      @users = User.looks(params[:word])
    elsif @model == "Post"
      @posts = Post.looks(params[:word])
    else  
    # elsif @model == "Itinerary"
      @itineraries = Itinerary.looks(params[:word])
      # @post_comment = PostComment.looks(params[:word])
    end
  end  
      
end
