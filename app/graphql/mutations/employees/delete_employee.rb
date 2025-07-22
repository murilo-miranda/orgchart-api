module Mutations
  module Employees
    class DeleteEmployee < Mutations::BaseMutation
      argument :id, ID, required: true

      field :employee, Types::EmployeeType, null: true
      field :errors, [ Types::BaseError ], null: false

      def resolve(id:)
        ::Employees::DeleteService.call(id: id)
      end
    end
  end
end
