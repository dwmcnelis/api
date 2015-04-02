# app/serializers/client_serializer.rb

class ClientSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :phone, :level, :rank, :status, :buzzes, :notes, :image, :tag_ids

  def image
    Rails.configuration.buzz.content_server+object.image_attachment.url
  end

	def tag_ids
		object.tags.pluck(:id)
	end

end
