# frozen_string_literal: true

module Types
  class BaseError < Types::BaseObject
    description "A user-readable error"

    field :message, String, null: false
    field :path, [ String ]
  end
end
