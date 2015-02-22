module V1

  class Leads < API

    version 'v1', using: :path
    format :json

    resource :leads do

      pagination per_page: 20, max_per_page: 30, offset: 0

      # GET /api/v1/leads
      desc 'Return list of leads' do
        detail <<EOS
This entry point is used to list leads.
EOS
      end
      get do
        benchmark do
          authenticate!
          authorize! Lead, :index?
          paginate current_user.leads
        end
      end


      # GET /api/v1/leads/:id
      desc 'Return a lead' do
        detail <<EOS
This entry point is used to return details about a given lead.
EOS
      end
      params do
        requires :id, type: String, regexp: UUID_REGEXP, desc: 'Lead id.'
      end
      get ':id' do
        benchmark do
          authenticate!
          @lead = exists! Lead.find_by_id(permitted_params[:id])
          authorize! @lead, :show?
          @lead
        end
      end

      # POST /api/v1/leads
      desc 'Create a new lead' do
        detail <<EOS
This entry point is used to create a new lead.
EOS
      end
      params do
        requires :lead, :type => Hash do
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
          authorize! Lead, :create?
          @lead = Lead.create!({
                                 user_id: current_user.id,
                                 first_name: permitted_params[:lead][:first_name],
                                 last_name: permitted_params[:lead][:last_name],
                                 email: permitted_params[:lead][:email],
                                 phone: permitted_params[:lead][:phone],
                                 status: permitted_params[:lead][:status],
                                 notes: permitted_params[:lead][:notes]
                               })
          @lead
        end
      end

      # PUT /api/v1/leads/:id
      desc 'Update a lead' do
        detail <<EOS
This entry point is used to update a lead.
EOS
      end
      params do
        requires :id, type: String, regexp: UUID_REGEXP, desc: "Lead id."
        requires :lead, :type => Hash do
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
          @lead = exists! Lead.find_by_id(permitted_params[:id])
          authorize! @lead, :update?
          @lead.update(permitted_params[:lead])
          @lead = Lead.find_by_id(permitted_params[:id])
          @lead
        end
      end

      # DELETE /api/v1/leads/:id
      desc 'Delete a lead' do
        detail <<EOS
This entry point is used to delete a lead.
EOS
      end
      params do
        requires :id, type: String, regexp: UUID_REGEXP, desc: "Lead id."
      end
      delete ':id' do
        benchmark do
          authenticate!
          @lead = exists! Lead.find_by_id(permitted_params[:id])
          authorize! @lead, :destroy?
          @lead.destroy
        end
      end

    end # resource

  end # Leads

end # V1

