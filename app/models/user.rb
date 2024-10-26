class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, presence: true
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, message: '半角英数字混合が必須'}
  validates :last_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: '全角(漢字・ひらがな・カタカナ)文字が必須' }
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: '全角(漢字・ひらがな・カタカナ)文字が必須' }
  validates :last_name_kana, presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: '全角（カタカナ）文字が必須' }
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: '全角（カタカナ）文字が必須' }
  validates :birth, presence: true
end
