class Employee < ApplicationRecord
  has_one_attached :picture

  validates :name, :email, presence: true
end
