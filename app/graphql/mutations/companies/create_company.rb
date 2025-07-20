module Mutations
  module Companies
    class CreateCompany < Mutations::BaseMutation
      argument :name, String, required: true

      field :company, Types::CompanyType, null: true
      field :errors, [ Types::CompanyErrorType ], null: false

      def resolve(name:)
        ::Companies::CreateService.call(name: name)
      end
    end
  end
end
