class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :area
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_charge
  belongs_to :shipping_day

  belongs_to :user
  has_one :purchase
  has_one_attached :image
end
