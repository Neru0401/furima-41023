class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, presence: true
  validates :last_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: '' }
  validates :first_name, presence: true,format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: '' }
  validates :last_name_kana, presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: '' }
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: '' }
  validates :birth, presence: true
end
