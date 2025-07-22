module Companies
  class CreateService < ApplicationService
    attr_reader :name

    def initialize(name:)
      @name = name
    end

    def call
      company = Company.new(name: @name)

      save_result(company)
    end

    def self.call(name:)
      new(name: name).call
    end
  end
end
