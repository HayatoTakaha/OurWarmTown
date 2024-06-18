module Users
  class UserGroupsController < ApplicationController
    def create
      @group = Group.find(params[:group_id])
      @user_group = @group.user_groups.build(user: current_user)
      if @user_group.save
        redirect_to group_path(@group), notice: 'グループに参加しました。'
      else
        redirect_to group_path(@group), alert: 'グループに参加できませんでした。'
      end
    end

    def destroy
      @user_group = UserGroup.find(params[:id])
      @user_group.destroy
      redirect_to group_path(@user_group.group), notice: 'グループから退出しました。'
    end

    private

    def user_group_params
      params.require(:user_group).permit(:user_id, :group_id)
    end
  end
end
