class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :area
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_charge
  belongs_to :shipping_day

  validates :product, presence: true
  validates :product_description, presence: true
  validates :price, presence: true, numericality:( greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 )  ,format: { with: /^[0-9]+$/ }

  validates :area, numericality: { other_than: 1 , message: "can't be blank" }
  validates :category, numericality: { other_than: 1 , message: "can't be blank" }
  validates :condition, numericality: { other_than: 1 , message: "can't be blank" }
  validates :shipping_charge, numericality: { other_than: 1 , message: "can't be blank" }
  validates :shipping_day, numericality: { other_than: 1 , message: "can't be blank" }

  belongs_to :user
  has_one_attached :image
end
