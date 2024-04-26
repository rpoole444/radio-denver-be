class UserSerializer
  include JSONAPI::Serializer

  set_type :user
  attributes :first_name, :last_name, :email, :password_digest
end
