class User < ApplicationRecord
  val_email = /\A.+@.+\..+\z/ #｢～@～.～｣
  val_password = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,32}\z/i #「8~32文字」かつ「半角英字と数字の混合」
  
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: val_email }
  validates :password, format: { with: val_password }
  has_secure_password
  
  has_one :blockeduser
  has_many :seats
  has_many :purchases
end
