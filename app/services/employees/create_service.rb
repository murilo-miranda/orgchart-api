module Employees
  class CreateService < ApplicationService
    attr_reader :company_id, :name, :email, :picture

    def initialize(company_id:, name:, email:, picture: nil)
      @company_id = company_id
      @name = name
      @email = email
      @picture = picture
    end

    def call
      employee = Employee.new(company_id: company_id, name: name, email: email)

      employee.picture.attach(
        io: picture.tempfile,
        filename: picture.original_filename,
        content_type: picture.content_type
      ) if picture.present?

      save_result(employee)
    end

    def self.call(company_id:, name:, email:, picture: nil)
      new(company_id: company_id, name: name, email: email, picture: picture).call
    end
  end
end
