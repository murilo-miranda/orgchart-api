module Employees
  class DeleteService < ApplicationService
    attr_reader :id

    def initialize(id:)
      @id = id
    end

    def call
      employee = Employee.find(id)
      delete_result(employee)
    end

    def self.call(id:)
      new(id: id).call
    end
  end
end
