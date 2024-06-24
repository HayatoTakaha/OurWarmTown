# app/controllers/admin_user/groups_controller.rb
class AdminUser::GroupsController < ApplicationController
  layout 'admin'

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to admin_user_group_path(@group), notice: 'Group was successfully created.'
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to admin_user_group_path(@group), notice: 'Group was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to admin_user_groups_path, notice: 'Group was successfully destroyed.'
  end

  private

  def group_params
    params.require(:group).permit(:name, :description)
  end
end
