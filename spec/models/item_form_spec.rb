require 'rails_helper'

RSpec.describe ItemForm, type: :model do
  before do
    user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item_form, user_id: user.id)
    @item.image = fixture_file_upload('app/assets/images/flag.png')
    sleep(0.1)
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
        expect(@item.errors.full_messages).to include('商品名を入力してください')
      end
      it 'product_descriptionが空だと登録できない' do
        @item.product_description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end
      it 'imageが空だと登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("画像を入力してください")
      end
      it 'priceが空だと登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("値段は数値で入力してください")
      end
      it 'priceに半角英数以外が含まれていると登録できない' do
        @item.price = '12３4'
        @item.valid?
        expect(@item.errors.full_messages).to include("値段は数値で入力してください", "値段は不正な値です")
      end
      it 'priceが299円以下だと登録できない' do
        @item.price = Faker::Number.between(from: 0, to: 299)
        @item.valid?
        expect(@item.errors.full_messages).to include("値段は300以上の値にしてください")
      end
      it 'priceが10000000円以上だと登録できない' do
        @item.price = Faker::Number.number(digits: 8)
        @item.valid?
        expect(@item.errors.full_messages).to include("値段は9999999以下の値にしてください")
      end
      it 'area_idが空だと登録できない' do
        @item.area_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域を選択してください")
      end
      it 'category_idが空だと登録できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを選択してください")
      end
      it 'condition_idが空だと登録できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態を選択してください")
      end
      it 'shippings_charge_idが空だと登録できない' do
        @item.shipping_charge_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("発送料の負担を選択してください")
      end
      it 'shippings_day_idが空だと登録できない' do
        @item.shipping_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数を選択してください")
      end
      it 'userが紐付いていないと登録できない' do
        @item.user_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Userを入力してください")
      end
    end
  end
end
