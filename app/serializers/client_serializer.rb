# app/serializers/client_serializer.rb

class ClientSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :phone, :level, :rank, :status, :buzzes, :notes, :image, :tags

  def image
    Rails.configuration.buzz.content_server+object.image_attachment.url
  end

	def tags
		object.tags.pluck(:id)
	end

end
