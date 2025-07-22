class ApplicationService
  def save_result(resource)
    process(resource, :save)
  end

  def delete_result(resource)
    process(resource, :destroy)
  end


  private
  def structure_errors(resource)
    resource.errors.map do |error|
      path = [ "attributes", error.attribute.to_s.camelize(:lower) ]
      { message: error.message, path: path }
    end
  end

  def process(resource, method)
    return { key(resource) => resource, errors: [] } if resource.send(method)

    { key(resource) => nil, errors: structure_errors(resource) }
  end

  def key(resource)
    resource.model_name.element.to_sym
  end
end
