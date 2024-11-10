class PurchaseShipping
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :purchase_id, :postal_code, :prefecture_id, :city, :address, :building, :telephone_number
  with_options presence: true do
    validates :user_id, :item_id, :purchase_id, :city, :address
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :phone_number, format: {with: /^(0{1}\d{9,10})$/,message:"is invalid. Input only number"}
  end
  validates :prefecture_id, numericality: {other_than: 0, message: "can't be blank"}

  def save
    purchase = Purchase.create(user_id: user_id, item_id:item_id)
    # donation_idには、変数donationのidと指定する
    Shipping.create(perchase: purchase_id, postal_code: postal_code, prefecture_id: prefecture.id, city: city, address: address, building: building, telephone_number: telephone_number)
  end
end