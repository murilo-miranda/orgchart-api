class Employee < ApplicationRecord
  belongs_to :company
  belongs_to :manager, class_name: "Employee", optional: true
  has_many :subordinates, class_name: "Employee", foreign_key: "manager_id"
  has_one_attached :picture

  before_destroy :nullify_manager

  validates :name, :email, presence: true
  validate :manager_cannot_be_managed

  def manager_cannot_be_managed
    return if id.nil?

    if manager&.manager_id == id
      errors.add(:manager_id, "não pode ser gestor de quem já é seu gestor")
    end
  end

  def nullify_manager
    self.subordinates.update_all(manager_id: nil)
  end
end
