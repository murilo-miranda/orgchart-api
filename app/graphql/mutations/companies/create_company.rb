module Mutations
  module Companies
    class CreateCompany < Mutations::BaseMutation
      argument :name, String, required: true

      field :company, Types::CompanyType, null: true
      field :errors, [Types::CompanyErrorType], null: false

      def resolve(name:)
        company = Company.new(name: name)

        if company.save
          { company: company, errors: [] }
        else
          company_errors = company.errors.map do |error|
            path = ["attributes", error.attribute.to_s.camelize(:lower)]
            { message: error.message, path: path }
          end

          { company: nil, errors: company_errors }
        end
      end
    end
  end
end
