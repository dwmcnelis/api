class ClientSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :phone, :level, :rank, :status, :buzzes, :notes
end
