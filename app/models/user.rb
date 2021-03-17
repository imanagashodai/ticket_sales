class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  has_secure_password
  # acts_as_paranoid

end
