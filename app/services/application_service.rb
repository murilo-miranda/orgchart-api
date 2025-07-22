class ApplicationService
  def save_result(resource)
    key = resource.model_name.element.to_sym

    return { key => resource, errors: [] } if resource.save

    { key => nil, errors: structure_errors(resource) }
  end


  private
  def structure_errors(resource)
    resource.errors.map do |error|
      path = [ "attributes", error.attribute.to_s.camelize(:lower) ]
      { message: error.message, path: path }
    end
  end
end
