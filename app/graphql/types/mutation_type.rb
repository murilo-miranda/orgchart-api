module Types
  class MutationType < Types::BaseObject
    field :create_company, mutation: Mutations::Companies::CreateCompany
    field :create_employee, mutation: Mutations::Employees::CreateEmployee
  end
end
