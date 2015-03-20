class ClientSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :phone, :level, :rank, :status, :buzzes, :notes, :image

  def image
    Rails.configuration.buzz.content_server+object.image_attachment.url
  end

end
