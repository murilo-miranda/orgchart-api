module Mutations
  module Employees
    class CreateEmployee < Mutations::BaseMutation
      argument :name, String, required: true
      argument :email, String, required: true
      argument :picture, ApolloUploadServer::Upload, required: false
      argument :company_id, ID, required: true

      field :employee, Types::EmployeeType, null: true
      field :errors, [ Types::BaseError ], null: false

      def resolve(company_id:, name:, email:, picture: nil)
        ::Employees::CreateService.call(company_id: company_id, name: name, email: email, picture: picture)
      end
    end
  end
end
