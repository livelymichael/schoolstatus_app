class Person < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { maximum: 40 }
  validates :address, presence: true, length: { maximum: 200 }
end
