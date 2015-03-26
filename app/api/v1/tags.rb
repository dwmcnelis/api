module V1

  class Tags < API

    version 'v1', using: :path
    format :json

    namespace :select_tags do

     # GET /api/v1/select_tags
      desc 'Return list of tags for select' do
        detail <<EOS
This entry point is used to list tags for select.
EOS
      end
      params do
        optional :as, type: String, desc: 'Tagged as type.'
        optional :query, type: String, desc: 'Query.'
      end
      get do
        benchmark do
          authenticate!
          authorize! Tag, :index?

          if params[:query]
            if params[:as]
              Tag.select2(Tag.tagged_as(params[:as]).search(params[:query]))
            else
              Tag.select2(Tag.search(params[:query]))
            end
          else
            if params[:as]
              Tag.select2(Tag.tagged_as(params[:as]))
            else
              Tag.select2(Tag.all)
            end
          end
        end
      end
    end

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
      end
      get do
        benchmark do
          authenticate!
          authorize! Tag, :index?
          if params[:query]
            paginate Tag.search(params[:query])
          else
            paginate Tag.all
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
          requires :name, type: String, desc: 'Name.'
          optional :as, type: String, desc: 'Tagged as type.'
          optional :description, type: String, desc: 'Description.'
          #optional :user_id, type: String, desc: 'User id.'
        end
      end
      post do
        benchmark do
          authenticate!
          authorize! Tag, :create?
          @tag = Tag.create!({
                                 user_id: current_user.id,
                                 #user_id: permitted_params[:tag][:user_id] ? permitted_params[:tag][:user_id] : current_user.id
                                 name: permitted_params[:tag][:name],
                                 as: permitted_params[:tag][:as],
                                 description: permitted_params[:tag][:description]
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
          requires :name, type: String, desc: 'Name.'
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

