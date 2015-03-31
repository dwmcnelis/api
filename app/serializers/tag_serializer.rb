class TagSerializer < ActiveModel::Serializer
  attributes :id, :as, :grouping, :text, :description

# "id",
# index ["as", "name", "description"],
# "aliases", "taggings_count", "grouping", "image_uid", "image_name", "user_id", "verified", 

  def text
  	object.name
  end

  # def image
  #   Rails.configuration.buzz.content_server+object.image_attachment.url
  # end

end
