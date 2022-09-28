class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create, :move_to_index, :purchase_edit_move_to_index]
  before_action :move_to_index, except: [:show, :new, :create]
  before_action :purchase_edit_move_to_index, except: [:show, :new, :create]

  def index
    @purchase_shipping = PurchaseShipping.new
  end

  def create
    @purchase_shipping = PurchaseShipping.new(pruchase_params)
    if @purchase_shipping.valid?
      pay_item
      @purchase_shipping.save
      redirect_to root_path
    else
      render :index
    end
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  private

  def pruchase_params
    params.require(:purchase_shipping).permit(:postal_code, :area_id, :municpality, :address1, :address2, :phone).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item[:price],  # 商品の値段
      card: pruchase_params[:token], # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end

  def move_to_index
    redirect_to root_path if user_signed_in? && current_user.id == @item.user.id
  end

  def purchase_edit_move_to_index
    redirect_to root_path unless user_signed_in? && @item.purchase.nil?
  end
end
