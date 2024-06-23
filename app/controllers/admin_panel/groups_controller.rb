# app/controllers/admin_panel/groups_controller.rb
module AdminPanel
  class GroupsController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_group, only: [:show, :edit, :update, :destroy]

    def index
      @groups = Group.all
    end

    def show
    end

    def edit
    end

    def update
      if @group.update(group_params)
        redirect_to admin_panel_group_path(@group), notice: 'グループが更新されました。'
      else
        render :edit
      end
    end

    def destroy
      @group.destroy
      redirect_to admin_panel_groups_path, notice: 'グループが削除されました。'
    end

    private

    def set_group
      @group = Group.find(params[:id])
    end

    def group_params
      params.require(:group).permit(:name, :description, :image)
    end
  end
end
