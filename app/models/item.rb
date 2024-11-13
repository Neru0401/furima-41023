class Item < ApplicationRecord
  belongs_to :user
  has_one :purchase
  has_one_attached :image
  has_one :purchase

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :deliveryfee
  belongs_to :prefecture
  belongs_to :shipdate

  validates :image, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :category_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :condition_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :delivery_fee_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :prefecture_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :ship_date_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :price, presence: true, numericality: { only_integer: true, message: 'Only half-width numbers can be used' }
  validates :price, presence: true, numericality: {
    greater_than_or_equal_to: 300,
    less_than_or_equal_to: 9_999_999,
    message: 'は300円から9,999,999円の間で設定してください'
  }
end
