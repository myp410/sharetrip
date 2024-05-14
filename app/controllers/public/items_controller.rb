class Public::ItemsController < ApplicationController
  def index
    @post = Post.find(params[:post_id])
    @item = @post.items.build(post_id: @post.id)
    @items = @post.items
    @tags = @post.tags.pluck(:name).join(',')
    @post_tags = @post.tags
  end

  def create
    @post = Post.find(params[:post_id])
    @item = Item.new(item_params)
    if @item.save
      redirect_to post_items_path ,notice: "持ち物を登録しました"
    else
      @tags = @post.tags.pluck(:name).join(',')
      @post_tags = @post.tags
      @items = @post.items
      render 'index'
    end
  end

  def destroy
    item = Item.find(params[:id])
    post = Post.find(params[:post_id])
    item.destroy
    redirect_to post_items_path(post)
  end

  def toggle
    render body: nil
    @item = Item.find(params[:id])
    @item.have = !@item.have
    @item.save
  end

  private

  def item_params
    params.require(:item).permit(:name, :post_id)
  end
end
