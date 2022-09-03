class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :area
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_charge
  belongs_to :shipping_day

  validates :area, numericality: { other_than: 1 , message: "can't be blank" }
  validates :category, numericality: { other_than: 1 , message: "can't be blank" }
  validates :condition, numericality: { other_than: 1 , message: "can't be blank" }
  validates :shipping_charge, numericality: { other_than: 1 , message: "can't be blank" }
  validates :shipping_day, numericality: { other_than: 1 , message: "can't be blank" }

  belongs_to :user
  has_one_attached :image
end
