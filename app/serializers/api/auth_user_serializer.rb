module Api
  class AuthUserSerializer < ActiveModel::Serializer
    attributes :id, :email, :role
  end
end