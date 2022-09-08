require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'product, product_description, price, area, category, condition, shipping_charge, shipping_dayが存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end

    context '登録できないとき' do
      it 'productが空だと登録できない' do
        @item.product = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Product can't be blank")
      end
      it 'product_descriptionが空だと登録できない' do
        @item.product_description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Product description can't be blank")
      end
      it 'imageが空だと登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it 'priceが空だと登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it 'priceに半角英数以外が含まれていると登録できない' do
        @item.price = '12３4'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it 'priceが299円以下だと登録できない' do
        @item.price = Faker::Number.between(from: 0, to: 299)
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end
      it 'priceが10000000円以上だと登録できない' do
        @item.price = Faker::Number.number(digits: 8)
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end
      it 'area_idが空だと登録できない' do
        @item.area_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Area can't be blank")
      end
      it 'category_idが空だと登録できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it 'condition_idが空だと登録できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end
      it 'shippings_charge_idが空だと登録できない' do
        @item.shipping_charge_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping charge can't be blank")
      end
      it 'shippings_day_idが空だと登録できない' do
        @item.shipping_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping day can't be blank")
      end
      it 'userが紐付いていないと登録できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end
    end
  end
end
