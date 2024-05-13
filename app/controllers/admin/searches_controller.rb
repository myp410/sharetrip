class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!
  
  def search
    @model = params[:model]
    @word = params[:word]
    
    if @model == "User"
      @users = User.looks(params[:word]).page(params[:page])
    elsif @model == "Post"
      @posts = Post.looks(params[:word]).page(params[:page])
    else
      @post_comments = PostComment.looks(params[:word]).page(params[:page])
    end
  end  
end
