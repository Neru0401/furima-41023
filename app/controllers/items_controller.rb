class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @Item = Item.new
  end
  
  private

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
