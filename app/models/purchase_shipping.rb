class PurchaseShipping
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :purchase_id, :postal_code, :prefecture_id, :city, :address, :building, :telephone_number

  with_options presence: true do
    validates :user_id, :item_id, :city, :address
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :telephone_number,
              numericality: { only_integer: true, message: 'Only half-width numbers can be used' },
              length: { minimum: 10, maximum: 11, message: 'should be 10 or 11 digits' }
  end
  validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }

  def save
    ActiveRecord::Base.transaction do
      purchase = Purchase.create!(user_id:, item_id:)
      Shipping.create!(
        purchase:,
        postal_code:,
        prefecture_id:,
        city:,
        address:,
        building:,
        telephone_number:
      )
    end
  end
end
