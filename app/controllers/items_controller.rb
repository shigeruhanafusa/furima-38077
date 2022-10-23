class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :move_to_index, :destroy]
  before_action :move_to_index, except: [:index, :show, :new, :create, :search, :tag_search]
  before_action :purchase_edit_move_to_index, except: [:index, :show, :new, :create, :search, :tag_search]

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
    @comments = @item.comments.includes(:user)
    @comment = Comment.new
  end

  def edit
    # @itemから情報をハッシュとして取り出し、@item_formとしてインスタンス生成する
    item_attributes = @item.attributes
    @item_form = ItemForm.new(item_attributes)
    @item_form.tag_name = @item.tags&.first&.tag_name
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

  def search
    return nil if params[:keyword] == ""
    tag = Tag.where(['tag_name LIKE ?', "%#{params[:keyword]}%"] )
    render json:{ keyword: tag }
  end

  def tag_search
    # params[:q]がnilではない且つ、params[:q][:name]がnilではないとき（商品名の欄が入力されているとき）
    # if params[:q] && params[:q][:name]と同じような意味合い
    if params[:q]&.dig(:product)
      # squishメソッドで余分なスペースを削除する
      squished_keywords = params[:q][:product].squish
      ## 半角スペースを区切り文字として配列を生成し、paramsに入れる
      params[:q][:product_cont_any] = squished_keywords.split(" ")
    end
    @q = Item.ransack(params[:q])
    @items = @q.result
  end


  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_form_params
    params.require(:item_form).permit(:product, :product_description, :price, :category_id, :condition_id,
                                 :shipping_charge_id, :area_id, :shipping_day_id, :tag_name, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in? && current_user.id == @item.user.id
  end

  def purchase_edit_move_to_index
    redirect_to action: :index unless user_signed_in? && @item.purchase.nil?
  end
end
