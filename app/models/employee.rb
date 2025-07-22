class Employee < ApplicationRecord
  belongs_to :company

  has_one_attached :picture

  validates :name, :email, presence: true
end
