class UserGroupsController < ApplicationController
  def create
    @group = Group.find(params[:group_id])
    @user_group = @group.user_groups.build(user: current_user)
    if @user_group.save
      redirect_to group_path(@group)
    else
      redirect_to group_path(@group), alert: '参加できませんでした。'
    end
  end

  def destroy
    @user_group = UserGroup.find(params[:id])
    @user_group.destroy
    redirect_to group_path(@user_group.group)
  end
end
