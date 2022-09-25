require 'rails_helper'

RSpec.describe PurchaseShipping, type: :model do
  describe '発送情報の保存' do
    before do
      item = FactoryBot.create(:item)
      user = FactoryBot.create(:user)
      @purchase  = FactoryBot.build(:purchase_shipping, user_id: user.id, item_id: item.id)
    end

    context 'すべての値が正しく入力されていれば保存できる' do
      it 'postal_code, municpality, user_id, item_id, address1, phone, area_idが存在すれば登録できる' do
        expect(@purchase).to be_valid
      end

      it 'address2が空でも保存できること' do
        @purchase.address2 = ''
        expect(@purchase).to be_valid 
      end
    end

    context '内容に問題がある場合' do
      it 'postal_codeが空だと保存できない' do
      end

      it 'municpalityが空だと保存できない' do
      end

      it 'address1が空だと保存できない' do
      end

      it 'phoneが空だと保存できない' do
      end

      it 'area_idが空だと保存できない' do
      end

      it 'user_idと紐づいていないと保存できない' do
      end

      it 'item_idと紐づいていないと保存できない' do
      end

      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できない' do
      end

      it 'phoneが10桁以上11桁以内の半角数値でないと保存できない' do
      end

      it 'phoneにハイフンを含むと保存できない' do
      end

    end

  end
end
