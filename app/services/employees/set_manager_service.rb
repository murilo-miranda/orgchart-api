module Employees
  class SetManagerService < ApplicationService
    attr_reader :id, :manager_id

    def initialize(id:, manager_id:)
      @id = id
      @manager_id = manager_id
    end

    def call
      employee = Employee.find_by(id: id)
      manager = Employee.find_by(id: manager_id)

      return { employee: nil, errors: [ "Employee not found" ] } unless employee
      return { employee: nil, errors: [ "Manager not found" ] } unless manager
      return {
        employee: employee,
        errors: [
          { message: "A manager cannot be managed", path: [ "attributes", "manager" ] }
          ]
      } if manager.manager_id == employee.id

      employee.manager = manager

      save_result(employee)
    end

    def self.call(id:, manager_id:)
      new(id: id, manager_id: manager_id).call
    end
  end
end
