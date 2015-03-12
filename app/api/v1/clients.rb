module V1

  class Clients < API

    version 'v1', using: :path
    format :json

    resource :clients do

      pagination per_page: 20, max_per_page: 30, offset: 0

      # GET /api/v1/clients
      desc 'Return list of clients' do
        detail <<EOS
This entry point is used to list clients.
EOS
      end
      get do
        benchmark do
          authenticate!
          authorize! Client, :index?
          paginate current_user.clients
        end
      end


      # GET /api/v1/clients/:id
      desc 'Return a client' do
        detail <<EOS
This entry point is used to return details about a given client.
EOS
      end
      params do
        requires :id, type: String, regexp: UUID_REGEXP, desc: 'Client id.'
      end
      get ':id' do
        benchmark do
          authenticate!
          @client = exists! Client.find_by_id(permitted_params[:id])
          authorize! @client, :show?
          @client
        end
      end

      # POST /api/v1/clients
      desc 'Create a new client' do
        detail <<EOS
This entry point is used to create a new client.
EOS
      end
      params do
        requires :client, :type => Hash do
          requires :first_name, type: String, desc: 'First name.'
          requires :last_name, type: String, desc: 'Last name.'
          optional :email, type: String, desc: 'Email address.'
          optional :phone, type: String, desc: 'Phone number.'
          optional :Status, type: String, desc: 'Status.'
          optional :Notes, type: String, desc: 'Notes.'
        end
      end
      post do
        benchmark do
          authenticate!
          authorize! Client, :create?
          @client = Client.create!({
                                 user_id: current_user.id,
                                 first_name: permitted_params[:client][:first_name],
                                 last_name: permitted_params[:client][:last_name],
                                 email: permitted_params[:client][:email],
                                 phone: permitted_params[:client][:phone],
                                 status: permitted_params[:client][:status],
                                 notes: permitted_params[:client][:notes]
                               })
          @client
        end
      end

      # PUT /api/v1/clients/:id
      desc 'Update a client' do
        detail <<EOS
This entry point is used to update a client.
EOS
      end
      params do
        requires :id, type: String, regexp: UUID_REGEXP, desc: "Client id."
        requires :client, :type => Hash do
          optional :first_name, type: String, desc: 'First name.'
          optional :last_name, type: String, desc: 'Last name.'
          optional :email, type: String, desc: 'Email address.'
          optional :phone, type: String, desc: 'Phone number.'
          optional :status, type: String, desc: 'Status.'
          optional :notes, type: String, desc: 'Notes.'
        end
      end
      put ':id' do
        benchmark do
          authenticate!
          @client = exists! Client.find_by_id(permitted_params[:id])
          authorize! @client, :update?
          @client.update(permitted_params[:client])
          @client = Client.find_by_id(permitted_params[:id])
          @client
        end
      end

      # DELETE /api/v1/clients/:id
      desc 'Delete a client' do
        detail <<EOS
This entry point is used to delete a client.
EOS
      end
      params do
        requires :id, type: String, regexp: UUID_REGEXP, desc: "Client id."
      end
      delete ':id' do
        benchmark do
          authenticate!
          @client = exists! Client.find_by_id(permitted_params[:id])
          authorize! @client, :destroy?
          @client.destroy
        end
      end

    end # resource

  end # Clients

end # V1
