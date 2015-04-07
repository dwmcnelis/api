# spec/api/teams_spec.rb

require 'rails_helper'

describe V1::Teams do
  subject { described_class }

  # GET /api/v1/teams
  describe 'GET /api/v1/teams' do
    let!(:user) { create(:user) }
    let!(:team1) { create(:team) }
    let!(:team2) { create(:team) }
    let!(:team3) { create(:team) }
    let!(:invalid_user) { nil }

    it 'returns team array' do
      headers = merge_headers(
        auth_header(user),
        accept_header('application/json')
      )

      get '/api/v1/teams', nil, headers

      expect(response.status).to eq(http_status(:ok))
      json = JSON.parse(response.body)
      expect(json.include?('teams')).to eq(true)
      teams = json['teams']
      expect(teams.count).to eq(3)
      expect(teams.map{|e| e['id']}.sort).to eq([team1.id, team2.id, team3.id].sort)
    end

    it 'returns team array with query' do
      headers = merge_headers(
        auth_header(user),
        accept_header('application/json')
      )

      get "/api/v1/teams?query=#{team1.name}", nil, headers

      expect(response.status).to eq(http_status(:ok))
      json = JSON.parse(response.body)
      expect(json.include?('teams')).to eq(true)
      teams = json['teams']
      expect(teams.count).to eq(1)
      expect(teams.map{|e| e['id']}).to eq([team1.id])
    end

	  it 'returns unauthorized when invalid user' do
    	headers = merge_headers(
    		auth_header(invalid_user),
    		accept_header('application/json')
    	)

      get '/api/v1/teams', nil, headers

      expect(response.status).to eq(http_status(:unauthorized))
    end
  end # 'GET /api/v1/teams'

  # GET /api/v1/teams/:id
  describe 'GET /api/v1/teams/:id' do
  	let!(:user) { create(:user) }
    let!(:team1) { create(:team) }
  	let!(:invalid_user) { nil }

    it 'returns team' do
    	headers = merge_headers(
    		auth_header(user),
    		accept_header('application/json')
    	)

      get "/api/v1/teams/#{team1.id}", nil, headers

      expect(response.status).to eq(http_status(:ok))
      json = JSON.parse(response.body)
	    expect(json.include?('team')).to eq(true)
      team = json['team']
      expect(team.include?('id')).to eq(true)
      expect(team.include?('name')).to eq(true)
			expect(team['id']).to eq(team1.id)
      expect(team['name']).to eq(team1.name)
    end

	  it 'returns unauthorized when invalid user' do
    	headers = merge_headers(
    		auth_header(invalid_user),
    		accept_header('application/json')
    	)

      get "/api/v1/teams/#{team1.id}", nil, headers

      expect(response.status).to eq(http_status(:unauthorized))
    end
  end # 'GET /api/v1/teams/:id'

  # POST /api/v1/teams
  describe 'POST /api/v1/teams' do
  	let!(:user) { create(:user) }
  	let!(:invalid_user) { nil }
  	let!(:mock_team) { create(:team) }

    it 'creates team' do
      params = {
      	team: {
          name: mock_team.name,
      	}
      }.to_json
    	headers = merge_headers(
    		auth_header(user),
        content_type_header('application/json'),
    		accept_header('application/json')
    	)

      post '/api/v1/teams', params, headers

      expect(response.status).to eq(http_status(:created))
      json = JSON.parse(response.body)
	    expect(json.include?('team')).to eq(true)
      team = json['team']
      expect(team.include?('id')).to eq(true)
      expect(team.include?('name')).to eq(true)
			expect(team['name']).to eq(mock_team.name)
    end

	  it 'returns unauthorized when invalid user' do
      params = {
        team: {
          name: mock_team.name,
        }
      }.to_json
    	headers = merge_headers(
    		auth_header(invalid_user),
        content_type_header('application/json'),
    		accept_header('application/json')
    	)

      post '/api/v1/teams', params, headers

      expect(response.status).to eq(http_status(:unauthorized))
    end
  end # 'POST /api/v1/teams'

  # PUT /api/v1/teams/:id
  describe 'PUT /api/v1/teams/:id' do
    let!(:user) { create(:user) }
    let!(:team1) { create(:team) }
    let!(:other_user) { create(:user) }
    let!(:other_team) { create(:team, user_id: other_user.id) }
    let!(:invalid_user) { nil }
    let!(:mock_team) { create(:team) }

    it 'updates team' do
      params = {
      	team: {
          name: mock_team.name,
      	}
      }.to_json
    	headers = merge_headers(
    		auth_header(user),
        content_type_header('application/json'),
    		accept_header('application/json')
    	)

      put "/api/v1/teams/#{team1.id}", params, headers

      expect(response.status).to eq(http_status(:ok))
      json = JSON.parse(response.body)
	    expect(json.include?('team')).to eq(true)
      team = json['team']
      expect(team.include?('id')).to eq(true)
      expect(team.include?('name')).to eq(true)
      expect(team['name']).to eq(mock_team.name)
    end

	  it 'returns forbidden when other users team' do
      params = {
      	team: {
          name: mock_team.name,
      	}
      }.to_json
    	headers = merge_headers(
    		auth_header(user),
        content_type_header('application/json'),
    		accept_header('application/json')
    	)

      put "/api/v1/teams/#{other_team.id}", params, headers

      expect(response.status).to eq(http_status(:forbidden))
    end

	  it 'returns unauthorized when invalid user' do
      params = {
      	team: {
          name: mock_team.name,
      	}
      }.to_json
    	headers = merge_headers(
    		auth_header(invalid_user),
        content_type_header('application/json'),
    		accept_header('application/json')
    	)

      put "/api/v1/teams/#{team1.id}", params, headers

      expect(response.status).to eq(http_status(:unauthorized))
    end
  end # 'PUT /api/v1/teams/:id'

  # DELETE /api/v1/teams/:id
  describe 'DELETE /api/v1/teams/:id' do
    let!(:user) { create(:user) }
    let!(:team1) { create(:team) }
    let!(:other_user) { create(:user) }
    let!(:other_team) { create(:team, user_id: other_user.id) }
    let!(:invalid_user) { nil }

    it 'returns team array when with teams' do
    	headers = merge_headers(
    		auth_header(user),
    		accept_header('application/json')
    	)

      delete "/api/v1/teams/#{team1.id}", nil, headers

      expect(response.status).to eq(http_status(:ok))
      json = JSON.parse(response.body)
      expect(json.include?('team')).to eq(true)
      team = json['team']
      expect(team.include?('id')).to eq(true)
			expect(team['id']).to eq(team1.id)
			expect(Team.exists?(team['id'])).to eq(false)
    end

	  it 'returns forbidden when other users team' do
    	headers = merge_headers(
    		auth_header(user),
    		accept_header('application/json')
    	)

      delete "/api/v1/teams/#{other_team.id}", nil, headers

      expect(response.status).to eq(http_status(:forbidden))
    end
    
	  it 'returns unauthorized when invalid user' do
    	headers = merge_headers(
    		auth_header(invalid_user),
    		accept_header('application/json')
    	)

      delete "/api/v1/teams/#{team1.id}", nil, headers

      expect(response.status).to eq(http_status(:unauthorized))
    end
  end # 'DELETE /api/v1/teams/:id'

end # V1::Teams