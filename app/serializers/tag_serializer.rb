# app/serializers/tag_serializer.rb

class TagSerializer < ActiveModel::Serializer
  attributes :id, :as, :grouping, :text, :description

  def as
  	object.as ? object.as : 'other'
  end

  def grouping
  	object.grouping ? object.grouping : 'other'
  end

  def text
  	object.name
  end

  # def image
  #   Rails.configuration.buzz.content_server+object.image_attachment.url
  # end

end
