class User < ApplicationRecord
  val_email = /\A.+@.+\..+\z/
  val_password = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,32}\z/i
  
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: val_email }
  validates :password, presence: true, format: { with: val_password }
  has_secure_password
  # acts_as_paranoid

end
