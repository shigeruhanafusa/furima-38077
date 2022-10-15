class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :area
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_charge
  belongs_to :shipping_day

  validates :product, presence: true
  validates :product_description, presence: true
  validates :image, presence: true
  validates :price, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }, format: { with: /\A[0-9]+\z/ }

  validates :area_id, numericality: { other_than: 1, message: "を選択してください" }
  validates :category_id, numericality: { other_than: 1, message: "を選択してください" }
  validates :condition_id, numericality: { other_than: 1, message: "を選択してください" }
  validates :shipping_charge_id, numericality: { other_than: 1, message: "を選択してください" }
  validates :shipping_day_id, numericality: { other_than: 1, message: "を選択してください" }

  belongs_to :user
  has_one :purchase
  has_one_attached :image
end
