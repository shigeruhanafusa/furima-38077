class PurchaseShipping
  include ActiveModel::Model
  attr_accessor :postal_code, :area_id, :municpality, :address1, :address2, :phone, :user_id, :item_id, :token

  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'に(-)を入れてください' }
    validates :token
    validates :user_id
    validates :item_id
    validates :municpality
    validates :address1
    validates :phone, format: { with: /\d{10,11}/, message: 'に(-)を入れてください' }
  end
  validates :area_id, numericality: { other_than: 1, message: 'を選択してください' }

  def save
    purchase = Purchase.create(item_id: item_id, user_id: user_id)
    Shipping.create(postal_code: postal_code, area_id: area_id, municpality: municpality, address1: address1, address2: address2,
                    phone: phone, purchase_id: purchase.id)
  end
end
