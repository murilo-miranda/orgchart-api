module Types
  class EmployeeType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false
    field :picture_url, String, null: true

    def picture_url
      object.picture.attached? ? Rails.application.routes.url_helpers.rails_blob_url(object.picture, only_path: true) : nil
    end
  end
end
