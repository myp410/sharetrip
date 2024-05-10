class Public::SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
    @model = params[:model]
    @word = params[:word]
    
    if @model == "User"
      @users = User.looks(params[:word]).page(params[:page])
    elsif @model == "Post"
      @posts = Post.looks(params[:word]).page(params[:page])
    elsif @model == "Itinerary"
      @itineraries = Itinerary.looks(params[:word]).page(params[:page])
    elsif @model == "PostComment"
      @post_comment = PostComment.looks(params[:word]).page(params[:page])
    else
      @tag = Tag.looks(params[:word]).page(params[:page])
    end
  end  
      
end
