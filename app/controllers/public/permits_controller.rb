class Public::PermitsController < ApplicationController
  before_action :authenticate_user!

  def create
    @group = Group.find(params[:group_id])
    permit = current_user.permits.new(group_id: params[:group_id])
    permit.save
    redirect_to request.referer, notice: "グループへの参加申請をしました"
  end

  def destroy
    permit = current_user.permits.find_by(group_id: params[:group_id])
    permit.destroy
    redirect_to request.referer, alert: "グループへの参加申請を取消しました"
  end

  def cancel_request
    @group = Group.find(params[:group_id])
    @permit = Permit.find(params[:id])
    if current_user.id == @group.owner_id
      @permit.destroy
      redirect_to request.referer, notice: "加入申請をキャンセルしました"
    else
      redirect_to request.referer, alert: "キャンセルに失敗しました"
    end
  end
end
