class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :check_owner, only: [:edit, :update, :destroy]
  before_action :check_item_availability, only: [:edit, :update, :destroy]

  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def check_owner
    redirect_to root_path unless @item.user == current_user
  end

  def check_item_availability
    return unless @item.purchase.present?

    redirect_to root_path
  end

  def item_params
    params.require(:item).permit(
      :title,
      :description,
      :category_id,
      :condition_id,
      :delivery_fee_id,
      :prefecture_id,
      :ship_date_id,
      :price,
      :image
    ).merge(user_id: current_user.id)
  end
end
