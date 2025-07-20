module Companies
  class CreateService
    attr_reader :name

    def initialize(name:)
      @name = name
    end

    def call
      company = Company.new(name: @name)

      return { company: company, errors: [] } if company.save

      { company: nil, errors: structure_errors(company) }
    end

    def self.call(name:)
      new(name: name).call
    end

    private
    def structure_errors(company)
      company.errors.map do |error|
        path = ["attributes", error.attribute.to_s.camelize(:lower)]
        { message: error.message, path: path }
      end
    end
  end
end
