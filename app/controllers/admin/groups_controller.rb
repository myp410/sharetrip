class Admin::GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @owner = User.find(@group.owner_id)
  end

  def edit
    @group = Group.find(params[:id])
  end
  
  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to admin_group_path(@group), notice: "グループの更新に成功しました"
    else
      render 'edit'
    end  
  end
  
  def destroy
    group = Group.find(params[:id])
    group.destroy
    redirect_to admin_groups_path, notice: "該当のグループを削除しました"
  end
  
  private
  
  def group_params
    params.require(:group).permit(:name, :introduction, :is_active, :owner_id)
  end  
end