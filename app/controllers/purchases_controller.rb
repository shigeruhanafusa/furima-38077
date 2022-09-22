class PurchasesController < ApplicationController
  before_action :authenticate_user!, except: :index
  
  def index
    @item = Item.find(params[:item_id])
    @purchase_shipping = PurchaseShipping.new
  end

  def create
    @purchase_shipping = PurchaseShipping.new(pruchase_params)
    @item = Item.find(params[:item_id])
    if @purchase_shipping.valid?
      @purchase_shipping.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def pruchase_params
    params.require(:purchase_shipping).permit(:postal_code, :area_id, :municpality, :address1, :address2, :phone).merge(user_id: current_user.id, item_id:params[:item_id])
  end

end
