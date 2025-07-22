module Employees
  class CreateService
    attr_reader :name, :email, :picture

    def initialize(name:, email:, picture: nil)
      @name = name
      @email = email
      @picture = picture
    end

    def call
      employee = Employee.new(name: name, email: email)

      employee.picture.attach(
        io: picture.tempfile,
        filename: picture.original_filename,
        content_type: picture.content_type
      ) if picture.present?

      return { employee: employee, errors: [] } if employee.save

      { employee: nil, errors: structure_errors(employee) }
    end

    def self.call(name:, email:, picture: nil)
      new(name: name, email: email, picture: picture).call
    end

    private
    def structure_errors(employee)
      employee.errors.map do |error|
        path = [ "attributes", error.attribute.to_s.camelize(:lower) ]
        { message: error.message, path: path }
      end
    end
  end
end
