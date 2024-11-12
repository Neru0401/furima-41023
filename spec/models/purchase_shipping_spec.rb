require 'rails_helper'

RSpec.describe PurchaseShipping, type: :model do
  before do
    @user = FactoryBot.create(:user)
    sleep 0.1
    @item = FactoryBot.create(:item, user_id: @user.id)
    sleep 0.1
    @purchase_shipping = FactoryBot.build(:purchase_shipping, user_id: @user.id, item_id: @item.id)
  end

  describe '商品購入' do
    context '商品購入できる場合' do
      it '全ての項目が正しく入力されていれば購入できる' do
        expect(@purchase_shipping).to be_valid
      end

      it 'buildingカラムは空でも購入できる' do
        @purchase_shipping.building = ''
        expect(@purchase_shipping).to be_valid
      end
    end

    context '商品購入できない場合' do
      it '郵便番号が空だと購入できない' do
        @purchase_shipping.postal_code = ''
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Postal code can't be blank")
      end

      it '郵便番号にハイフンを含む正しい形式でないと購入できない' do
        @purchase_shipping.postal_code = '1234567'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end

      it '都道府県選択されていないと購入できない' do
        @purchase_shipping.prefecture_id = 0
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '市区町村が空だと購入できない' do
        @purchase_shipping.city = ''
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("City can't be blank")
      end

      it '番地が空だと購入できない' do
        @purchase_shipping.address = ''
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Address can't be blank")
      end

      it '電話番号が空だと購入できない' do
        @purchase_shipping.telephone_number = ''
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Telephone number can't be blank")
      end

      it '電話番号に数字以外が含まれていると購入できない' do
        @purchase_shipping.telephone_number = '090-0000-1234'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include('Telephone number Only half-width numbers can be used')
      end

      it '電話番号が10桁未満だと購入できない' do
        @purchase_shipping.telephone_number = '012345678'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include('Telephone number should be 10 or 11 digits')
      end

      it '電話番号が12桁以上だと購入できない' do
        @purchase_shipping.telephone_number = '012345678910'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include('Telephone number should be 10 or 11 digits')
      end

      it 'tokenが空だと購入できない' do
        @purchase_shipping.token = ''
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
