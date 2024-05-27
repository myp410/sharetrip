class Public::SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
    @model = params[:model]
    @word = params[:word]
    
    if @model == "User"
      @users = User.looks(params[:word]).page(params[:page])
    elsif @model == "Post"
      @posts = Post.published.looks(params[:word]).page(params[:page])
    elsif @model == "Itinerary"
      @itineraries = Itinerary.looks(params[:word]).page(params[:page])
    elsif @model == "PostComment"
      @post_comments = PostComment.looks(params[:word]).page(params[:page])
    else
      @tags = Tag.looks(params[:word]).page(params[:page])
    end
  end  
      
end
