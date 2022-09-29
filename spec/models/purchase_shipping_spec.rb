require 'rails_helper'

RSpec.describe PurchaseShipping, type: :model do
  describe '発送情報の保存' do
    before do
      item = FactoryBot.create(:item)
      user = FactoryBot.create(:user)
      @purchase = FactoryBot.build(:purchase_shipping, user_id: user.id, item_id: item.id)
      sleep(0.5)
    end

    context 'すべての値が正しく入力されていれば保存できる' do
      it 'postal_code, municpality, user_id, item_id, address1, phone, area_id, tokenが存在すれば登録できる' do
        expect(@purchase).to be_valid
      end

      it 'address2が空でも保存できること' do
        @purchase.address2 = ''
        expect(@purchase).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'postal_codeが空だと保存できない' do
        @purchase.postal_code = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'municpalityが空だと保存できない' do
        @purchase.municpality = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Municpality can't be blank")
      end

      it 'address1が空だと保存できない' do
        @purchase.address1 = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Address1 can't be blank")
      end

      it 'phoneが空だと保存できない' do
        @purchase.phone = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Phone can't be blank")
      end

      it 'area_idが空だと保存できない' do
        @purchase.area_id = 1
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Area can't be blank")
      end

      it 'tokenが空だと保存できない' do
        @purchase.token = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Token can't be blank")
      end

      it 'user_idと紐づいていないと保存できない' do
        @purchase.user_id = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("User can't be blank")
      end

      it 'item_idと紐づいていないと保存できない' do
        @purchase.item_id = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Item can't be blank")
      end

      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できない' do
        @purchase.postal_code = 1_234_567
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end

      it 'phoneが12桁以上の半角数値では保存できない' do
        @purchase.phone = Faker::Number.between(from: 12, to: 30)
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('Phone is invalid. Include hyphen(-)')
      end

      it 'phoneが9桁以下の半角数値では保存できない' do
        @purchase.phone = Faker::Number.between(from: 0, to: 9)
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('Phone is invalid. Include hyphen(-)')
      end

      it 'phoneにハイフンを含むと保存できない' do
        @purchase.phone = 123 - 4567 - 8910
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('Phone is invalid. Include hyphen(-)')
      end
    end
  end
end
