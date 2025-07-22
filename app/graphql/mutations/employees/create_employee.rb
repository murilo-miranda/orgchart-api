module Mutations
  module Employees
    class CreateEmployee < Mutations::BaseMutation
      argument :name, String, required: true
      argument :email, String, required: true
      argument :picture, ApolloUploadServer::Upload, required: false

      field :employee, Types::EmployeeType, null: true
      field :errors, [ Types::BaseError ], null: false

      def resolve(name:, email:, picture: nil)
        ::Employees::CreateService.call(name: name, email: email, picture: picture)
      end
    end
  end
end
