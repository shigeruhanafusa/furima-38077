class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :move_to_index, :destroy]
  before_action :move_to_index, except: [:index, :show, :new, :create]
  before_action :purchase_edit_move_to_index, except: [:index, :show, :new, :create]

  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    @item_form = ItemForm.new
  end

  def create
    @item_form = ItemForm.new(item_form_params)
    if @item_form.valid? 
      @item_form.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    # @postから情報をハッシュとして取り出し、@post_formとしてインスタンス生成する
    item_attributes = @item.attributes
    @item_form = ItemForm.new(item_attributes)
  end

  def update
    @item_form = ItemForm.new(item_form_params)

    # 画像を選択し直していない場合は、既存の画像をセットする
    @item_form.image ||= @item.image.blob

    if @item_form.valid?
      @item_form.update(item_form_params, @item)
      redirect_to item_path
    else
      render :edit
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

  def item_form_params
    params.require(:item_form).permit(:image, :product, :product_description, :price, :category_id, :condition_id,
                                 :shipping_charge_id, :area_id, :shipping_day_id).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in? && current_user.id == @item.user.id
  end

  def purchase_edit_move_to_index
    redirect_to action: :index unless user_signed_in? && @item.purchase.nil?
  end
end
