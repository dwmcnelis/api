# app/api/v1/tags.rb

# Tags API
#

module V1

  class Tags < API

    version 'v1', using: :path, vendor: 'clientbuzz'#, cascade: false
    prefix 'api'
    format :json

    resource :tags do

      pagination per_page: 20, max_per_page: 30, offset: 0

      # GET /api/v1/tags
      desc 'Return list of tags' do
        detail <<EOS
This entry point is used to list tags.
EOS
      end
      params do
        optional :query, type: String, desc: 'Query.'
        optional :as, type: String, desc: 'Tagged as type.'
      end
      get do
        benchmark do
          authenticate!
          authorize! Tag, :index?
          if params[:query]
            if params[:as]
              paginate Tag.where(user_id: [nil,current_user.id]).tagged_as(params[:as]).search(params[:query])
            else
              paginate Tag.where(user_id: [nil,current_user.id]).search(params[:query])
            end
          else
            if params[:as]
              paginate Tag.where(user_id: [nil,current_user.id]).tagged_as(params[:as])
            else
              paginate Tag.where(user_id: [nil,current_user.id])
            end
          end
        end
      end


      # GET /api/v1/tags/:id
      desc 'Return a tag' do
        detail <<EOS
This entry point is used to return details about a given tag.
EOS
      end
      params do
        requires :id, type: String, regexp: UUID_REGEXP, desc: 'tag id.'
      end
      get ':id' do
        benchmark do
          authenticate!
          @tag = exists! Tag.find_by_id(permitted_params[:id])
          authorize! @tag, :show?
          @tag
        end
      end

      # POST /api/v1/tags
      desc 'Create a new tag' do
        detail <<EOS
This entry point is used to create a new tag.
EOS
      end
      params do
        requires :tag, :type => Hash do
          requires :text, type: String, desc: 'Text.'
          optional :as, type: String, desc: 'Tagged as type.'
          optional :description, type: String, desc: 'Description.'
          optional :tagged_type, type: String, desc: 'Tagged type.'
          optional :tagged_id, type: String, desc: 'Tagged id.'
          #optional :user_id, type: String, desc: 'User id.'
        end
      end
      post do
        benchmark do
          authenticate!
          authorize! Tag, :create?
          @tag = Tag.create!({
            as: permitted_params[:tag][:as],
            name: permitted_params[:tag][:text],
            description: permitted_params[:tag][:description],
            user_id: current_user.id,
            #user_id: permitted_params[:tag][:user_id] ? permitted_params[:tag][:user_id] : current_user.id,
          })
          @tagging = Tagging.create!({
            as: permitted_params[:tag][:as],
            tag_id: @tag.id,
            tagged_type: permitted_params[:tag][:tagged_type],
            tagged_id: permitted_params[:tag][:tagged_id],
            user_id: current_user.id,
            #user_id: permitted_params[:tag][:user_id] ? permitted_params[:tag][:user_id] : current_user.id,
          })
          @tag
        end
      end

      # PUT /api/v1/tags/:id
      desc 'Update a tag' do
        detail <<EOS
This entry point is used to update a tag.
EOS
      end
      params do
        requires :id, type: String, regexp: UUID_REGEXP, desc: "tag id."
        requires :tag, :type => Hash do
          optional :name, type: String, desc: 'Name.'
          optional :as, type: String, desc: 'Tagged as type.'
          optional :description, type: String, desc: 'Description.'
          #optional :user_id, type: String, desc: 'User id.'
        end
      end
      put ':id' do
        benchmark do
          authenticate!
          @tag = exists! Tag.find_by_id(permitted_params[:id])
          authorize! @tag, :update?
          @tag.update(permitted_params[:tag])
          @tag = Tag.find_by_id(permitted_params[:id])
          @tag
        end
      end

      # DELETE /api/v1/tags/:id
      desc 'Delete a tag' do
        detail <<EOS
This entry point is used to delete a tag.
EOS
      end
      params do
        requires :id, type: String, regexp: UUID_REGEXP, desc: "tag id."
      end
      delete ':id' do
        benchmark do
          authenticate!
          @tag = exists! Tag.find_by_id(permitted_params[:id])
          authorize! @tag, :destroy?
          @tag.destroy
        end
      end

    end # resource

  end # tags

end # V1

