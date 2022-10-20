class ItemForm
  include ActiveModel::Model

  attr_accessor :category_id, :product, :product_description, :condition_id, :id, :created_at, :updated_at,
                :shipping_charge_id, :area_id, :shipping_day_id, :price, :user_id, :image

  with_options presence: true do
    validates :product, presence: true
    validates :product_description, presence: true
    validates :image, presence: true
    validates :price, presence: true,
                      numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }, format: { with: /\A[0-9]+\z/ }
  end
    validates :area_id, numericality: { other_than: 1, message: "を選択してください" }
    validates :category_id, numericality: { other_than: 1, message: "を選択してください" }
    validates :condition_id, numericality: { other_than: 1, message: "を選択してください" }
    validates :shipping_charge_id, numericality: { other_than: 1, message: "を選択してください" }
    validates :shipping_day_id, numericality: { other_than: 1, message: "を選択してください" }

    def save
      Item.create(category_id: category_id, product: product, product_description: product_description, condition_id: condition_id,
                  shipping_charge_id: shipping_charge_id, area_id: area_id, shipping_day_id: shipping_day_id, price: price, user_id: user_id, image: image)
    end

    def update(params, item)
      item.update(params)
    end
end