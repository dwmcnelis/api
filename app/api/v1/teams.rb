module V1

  class Teams < API

    version 'v1', using: :path
    format :json

    resource :teams do

      pagination per_page: 20, max_per_page: 30, offset: 0

      # GET /api/v1/teams
      desc 'Return list of teams' do
        detail <<EOS
This entry point is used to list teams.
EOS
      end
      get do
        benchmark do
          authenticate!
          authorize! Team, :index?
          paginate Team.all
        end
      end


      # GET /api/v1/teams/:id
      desc 'Return a team' do
        detail <<EOS
This entry point is used to return details about a given team.
EOS
      end
      params do
        requires :id, type: String, regexp: UUID_REGEXP, desc: 'team id.'
      end
      get ':id' do
        benchmark do
          authenticate!
          @team = exists! team.find_by_id(permitted_params[:id])
          authorize! @team, :show?
          @team
        end
      end

      # POST /api/v1/teams
      desc 'Create a new team' do
        detail <<EOS
This entry point is used to create a new team.
EOS
      end
      params do
        requires :team, :type => Hash do
          requires :name, type: String, desc: 'Name.'
          # optional :level, type: String, desc: 'Last name.'
          # optional :type, type: String, desc: 'xxx.'
          # optional :league_id, type: Fixnum, desc: 'xxx.'
          # optional :division_id, type: String, desc: 'xxx.'
          # optional :founded, type: Date, desc: 'xxx.'
          # optional :location, type: String, desc: 'xxx.'
          # optional :arena, type: String, desc: 'xxx.'
          # optional :user_id, type: String, desc: 'xxx.'
        end
      end
      post do
        benchmark do
          authenticate!
          authorize! team, :create?
          @team = team.create!({
                                 user_id: current_user.id,
                                 name: permitted_params[:team][:name],
                                 level: permitted_params[:team][:level],
                                 type: permitted_params[:team][:type],
                                 league_id: permitted_params[:team][:league_id],
                                 division_id: permitted_params[:team][:division_id],
                                 founded: permitted_params[:team][:founded],
                                 location: permitted_params[:team][:location],
                                 arena: permitted_params[:team][:arena]
                               })
          @team
        end
      end

      # PUT /api/v1/teams/:id
      desc 'Update a team' do
        detail <<EOS
This entry point is used to update a team.
EOS
      end
      params do
        requires :id, type: String, regexp: UUID_REGEXP, desc: "team id."
        requires :team, :type => Hash do
          requires :name, type: String, desc: 'Name.'
          # optional :level, type: String, desc: 'Last name.'
          # optional :type, type: String, desc: 'xxx.'
          # optional :league_id, type: Fixnum, desc: 'xxx.'
          # optional :division_id, type: String, desc: 'xxx.'
          # optional :founded, type: Date, desc: 'xxx.'
          # optional :location, type: String, desc: 'xxx.'
          # optional :arena, type: String, desc: 'xxx.'
          # optional :user_id, type: String, desc: 'xxx.'
        end
      end
      put ':id' do
        benchmark do
          authenticate!
          @team = exists! team.find_by_id(permitted_params[:id])
          authorize! @team, :update?
          @team.update(permitted_params[:team])
          @team = team.find_by_id(permitted_params[:id])
          @team
        end
      end

      # DELETE /api/v1/teams/:id
      desc 'Delete a team' do
        detail <<EOS
This entry point is used to delete a team.
EOS
      end
      params do
        requires :id, type: String, regexp: UUID_REGEXP, desc: "team id."
      end
      delete ':id' do
        benchmark do
          authenticate!
          @team = exists! team.find_by_id(permitted_params[:id])
          authorize! @team, :destroy?
          @team.destroy
        end
      end

    end # resource

  end # teams

end # V1

