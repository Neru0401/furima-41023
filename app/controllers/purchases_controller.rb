class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :check_purchase_eligibility

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @purchase_shipping = PurchaseShipping.new
  end

  def create
    @purchase_shipping = PurchaseShipping.new(purchase_params)
    if @purchase_shipping.valid?
      pay_purchase
      @purchase_shipping.save
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def check_purchase_eligibility
    if @item.user_id == current_user.id
      redirect_to root_path
    elsif @item.purchase.present?
      redirect_to root_path
    end
  end
  def purchase_params
    params.require(:purchase_shipping).permit(
      :postal_code,
      :prefecture_id,
      :city,
      :address,
      :building,
      :telephone_number
    ).merge(item_id: params[:item_id], user_id: current_user.id, token: params[:token])
  end

  def pay_purchase
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end
end