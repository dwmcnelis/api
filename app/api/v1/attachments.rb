# app/api/v1/attachments.rb

# Attachments API
#

module V1

  class Attachments < API

    version 'v1', using: :path, vendor: 'clientbuzz'#, cascade: false
    prefix 'api'
    format :json

    namespace :attachments do

      # POST /api/v1/attachments
      desc 'Upload an attachment file' do
      detail <<EOS
This entry point is used to upload an attachment file and associate its contents with specified object.
EOS
      end
      params do
        requires :attachment, :type => Hash do
          requires :for_type, type: String, desc: 'For type.'
          requires :for_id, type: String, desc: 'For id.'
          requires :for_attribute, type: String, desc: 'For attribute.'
          requires :content, type: Hash do
            #requires :filename, desc: 'For attribute.'
            #requires :type, desc: 'For attribute.'
            #requires :name, desc: 'For attribute.'
            requires :tempfile, desc: 'Content temporary file.'
            #requires :head, desc: 'For attribute.'

            #["name", "lastModifiedDate", "size", "type"]
          end
          optional :name, type: String, desc: 'Content file name.'
          #optional :mime_type, type: String, desc: 'Content mime type.'
          #optional :size, type: Fixnum, desc: 'Content size.'
        end
      end
      post do
        benchmark do
          authenticate!

          for_type = params[:attachment][:for_type]
          for_id = params[:attachment][:for_id]
          for_attribute = params[:attachment][:for_attribute]
          kind = for_type.capitalize.constantize

          error!({error:  'Forbidden',
                  detail: "Not authorized for resource",
                  status: '403'},
                 403) unless kind.column_names.include?("#{for_attribute}_uid")

          @object = exists! kind.find_by_id(for_id)

          authorize! @object, :update?

          @object.send("#{for_attribute}=",params[:attachment][:content][:tempfile])
          @object.send(for_attribute).name = params[:attachment][:name] if params[:attachment][:name]
          @object.save
          @object = kind.find_by_id(for_id)
          {attachment: {
              content: nil,

              name: @object.image.name,
              mime_type: @object.image.mime_type,
              size: @object.image.size,
              url: Rails.configuration.buzz.content_server+@object.image.url,

              for_type: for_type,
              for_id: for_id,
              for_attribute: for_attribute
            }
          }
        end
      end
    end # namespace

  end # Attachments

end # V1

