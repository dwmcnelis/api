class ClientSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :phone, :level, :rank, :status, :buzzes, :notes, :image

  def image
    'http://localhost:3002'+object.image.url
  end

end
