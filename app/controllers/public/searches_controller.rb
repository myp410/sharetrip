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
      @posts = Post.where(status: :published)
      @itineraries = Itinerary.none
      @posts.each do |post|
        @itineraries = @itineraries.or(post.itineraries.looks(params[:word]))
      end
      @itineraries = @itineraries.page(params[:page]).per(10)
    else
      @tags = Tag.looks(params[:word]).page(params[:page])
    end
  end

end
