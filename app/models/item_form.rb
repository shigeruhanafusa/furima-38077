class ItemForm
  include ActiveModel::Model

  attr_accessor :category_id, :product, :product_description, :condition_id, :id, :created_at, :updated_at,
                :shipping_charge_id, :area_id, :shipping_day_id, :price, :user_id, :tag_name, :item_id, :image

  with_options presence: true do
    validates :product
    validates :product_description
    validates :image
    validates :price,
                      numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }, format: { with: /\A[0-9]+\z/ }
  end
  validates :area_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :category_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :condition_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :shipping_charge_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :shipping_day_id, numericality: { other_than: 1, message: 'を選択してください' }

  def save
    item = Item.create(category_id: category_id, product: product, product_description: product_description, condition_id: condition_id,
                       shipping_charge_id: shipping_charge_id, area_id: area_id, shipping_day_id: shipping_day_id, price: price, user_id: user_id, image: image)
    tag = Tag.where(tag_name: tag_name).first_or_initialize
    tag.save
    ItemTagRelation.create(item_id: item.id, tag_id: tag.id)
  end

  def update(params, item)
    # 一度タグの紐付けを消す
    item.item_tag_relations.destroy_all

    # paramsの中のタグの情報を削除。同時に、返り値としてタグの情報を変数に代入
    tag_name = params.delete(:tag_name)

    # もしタグの情報がすでに保存されていればインスタンスを取得、無ければインスタンスを新規作成
    tag = Tag.where(tag_name: tag_name).first_or_initialize if tag_name.present?

    # タグを保存
    tag.save if tag_name.present?
    item.update(params)
    ItemTagRelation.create(item_id: item.id, tag_id: tag.id) if tag_name.present?
  end
end
