class AddManagerToEmployees < ActiveRecord::Migration[8.0]
  def change
    add_column :employees, :manager_id, :integer
    add_foreign_key :employees, :employees, column: :manager_id
  end
end
