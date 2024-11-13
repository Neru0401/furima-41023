class PurchaseShipping
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :address, :building, :telephone_number, :token

  with_options presence: true do
    validates :user_id, :item_id, :city, :address, :token
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :telephone_number,
              format: { with: /\A[0-9]+\z/, message: 'Only half-width numbers can be used' },
              length: { in: 10..11, message: 'should be 10 or 11 digits' }
  end
  validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }

  def save
    purchase = Purchase.create(user_id:, item_id:)
    Shipping.create(
      postal_code:,
      prefecture_id:,
      city:,
      address:,
      building:,
      telephone_number:,
      purchase_id: purchase.id
    )
  end
end
