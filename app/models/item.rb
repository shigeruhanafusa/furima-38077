class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  # validates :product, presence: true

  belongs_to :area
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_charge
  belongs_to :shipping_day

  belongs_to :user
  has_one :purchase
  has_one_attached :image

  has_many :item_tag_relations
  has_many :tags, through: :item_tag_relations
  has_many :comments
end
