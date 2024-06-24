class Room < ApplicationRecord

    belongs_to :user # ユーザーとの関連付け
    validates :name, presence: true # 施設名の必須項目バリデーション
    validates :price, presence: true, numericality: { greater_than: 0 } # 料金の必須項目バリデーション
    has_one_attached :image
    has_many :reservations
    
  end
  

