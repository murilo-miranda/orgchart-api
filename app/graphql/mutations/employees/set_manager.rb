module Mutations
  module Employees
    class SetManager < Mutations::BaseMutation
      argument :id, ID, required: true
      argument :manager_id, ID, required: true

      field :employee, Types::EmployeeType, null: false
      field :errors, [ Types::BaseError ], null: false

      def resolve(id:, manager_id:)
        ::Employees::SetManagerService.call(id: id, manager_id: manager_id)
      end
    end
  end
end
