# spec/api/tags_spec.rb

require 'rails_helper'

describe V1::Tags do
  subject { described_class }

  # GET /api/v1/tags
  describe 'GET /api/v1/tags' do
    let!(:user) { create(:user) }
    let!(:team1) { create(:team) }
    let!(:team2) { create(:team) }
    let!(:team3) { create(:team) }
    let!(:tag1) { create(:tag, as: 'sports', for_type: team1.class.name, for_id: team1.id) }
    let!(:tag2) { create(:tag, as: 'sports', for_type: team2.class.name, for_id: team2.id) }
    let!(:tag3) { create(:tag, as: 'sports', for_type: team3.class.name, for_id: team3.id) }
    let!(:invalid_user) { nil }

    it 'returns tag array' do
      headers = merge_headers(
        auth_header(user),
        accept_header('application/json')
      )

      get '/api/v1/tags', nil, headers

      expect(response.status).to be_status_ok
      json = JSON.parse(response.body)
      expect(json.include?('tags')).to eq(true)
      tags = json['tags']
      expect(tags.count).to eq(3)
      expect(tags.map{|e| e['id']}.sort).to eq([tag1.id, tag2.id, tag3.id].sort)
    end

    it 'returns tag array with query' do
      headers = merge_headers(
        auth_header(user),
        accept_header('application/json')
      )

      get "/api/v1/tags?as=sports&query=#{tag1.name}", nil, headers

      expect(response.status).to be_status_ok
      json = JSON.parse(response.body)
      expect(json.include?('tags')).to eq(true)
      tags = json['tags']
      expect(tags.count).to eq(1)
      expect(tags.map{|e| e['id']}).to eq([tag1.id])
    end

	  it 'returns unauthorized when invalid user' do
    	headers = merge_headers(
    		auth_header(invalid_user),
    		accept_header('application/json')
    	)

      get '/api/v1/tags', nil, headers

      expect(response.status).to be_status_unauthorized
    end
  end # 'GET /api/v1/tags'

  # GET /api/v1/tags/:id
  describe 'GET /api/v1/tags/:id' do
  	let!(:user) { create(:user) }
    let!(:team1) { create(:team) }
    let!(:tag1) { create(:tag, as: 'sports', for_type: team1.class.name, for_id: team1.id, grouping: 'other') }
  	let!(:invalid_user) { nil }

    it 'returns tag' do
    	headers = merge_headers(
    		auth_header(user),
    		accept_header('application/json')
    	)

      get "/api/v1/tags/#{tag1.id}", nil, headers

      expect(response.status).to be_status_ok
      json = JSON.parse(response.body)
	    expect(json.include?('tag')).to eq(true)
      tag = json['tag']
      expect(tag.include?('id')).to eq(true)
      expect(tag.include?('as')).to eq(true)
      expect(tag.include?('grouping')).to eq(true)
      expect(tag.include?('text')).to eq(true)
      expect(tag.include?('description')).to eq(true)
			expect(tag['id']).to eq(tag1.id)
			expect(tag['as']).to eq(tag1.as)
			expect(tag['grouping']).to eq(tag1.grouping)
      expect(tag['text']).to eq(tag1.name)
      expect(tag['description']).to eq(tag1.description)
    end

	  it 'returns unauthorized when invalid user' do
    	headers = merge_headers(
    		auth_header(invalid_user),
    		accept_header('application/json')
    	)

      get "/api/v1/tags/#{tag1.id}", nil, headers

      expect(response.status).to be_status_unauthorized
    end
  end # 'GET /api/v1/tags/:id'

  # POST /api/v1/tags
  describe 'POST /api/v1/tags' do
  	let!(:user) { create(:user) }
    let!(:team1) { create(:team) }
  	let!(:invalid_user) { nil }
  	let!(:mock_tag) { create(:tag) }

    it 'creates tag' do
      params = {
      	tag: {
	        as: 'sports',
          text: team1.name,
	        description: 'other',
	        tagged_type: team1.class.name,
	        tagged_id: team1.id,
      	}
      }.to_json
    	headers = merge_headers(
    		auth_header(user),
        content_type_header('application/json'),
    		accept_header('application/json')
    	)

      post '/api/v1/tags', params, headers

      expect(response.status).to be_status_created
      json = JSON.parse(response.body)
	    expect(json.include?('tag')).to eq(true)
      tag = json['tag']
      expect(tag.include?('id')).to eq(true)
      expect(tag.include?('as')).to eq(true)
      expect(tag.include?('grouping')).to eq(true)
      expect(tag.include?('text')).to eq(true)
      expect(tag.include?('description')).to eq(true)
			expect(tag['as']).to eq('sports')
			expect(tag['grouping']).to eq('other')
			expect(tag['text']).to eq(team1.name)
			expect(tag['description']).to eq('other')
    end

	  it 'returns unauthorized when invalid user' do
      params = {
        tag: {
          as: 'sports',
          text: team1.name,
          description: 'other',
          tagged_type: team1.class.name,
          tagged_id: team1.id,
        }
      }.to_json
    	headers = merge_headers(
    		auth_header(invalid_user),
        content_type_header('application/json'),
    		accept_header('application/json')
    	)

      post '/api/v1/tags', params, headers

      expect(response.status).to be_status_unauthorized
    end
  end # 'POST /api/v1/tags'

  # PUT /api/v1/tags/:id
  describe 'PUT /api/v1/tags/:id' do
    let!(:user) { create(:user) }
    let!(:team1) { create(:team) }
    let!(:tag1) { create(:tag, as: 'sports', for_type: team1.class.name, for_id: team1.id, grouping: 'other') }
    let!(:other_user) { create(:user) }
    let!(:other_team) { create(:team) }
    let!(:other_tag) { create(:tag, as: 'sports', for_type: other_team.class.name, for_id: other_team.id, grouping: 'other', user_id: other_user.id) }
    let!(:invalid_user) { nil }
    let!(:mock_tag) { create(:tag) }

    it 'updates tag' do
      params = {
      	tag: {
	        name: mock_tag.name,
          description: 'other'
      	}
      }.to_json
    	headers = merge_headers(
    		auth_header(user),
        content_type_header('application/json'),
    		accept_header('application/json')
    	)

      put "/api/v1/tags/#{tag1.id}", params, headers

      expect(response.status).to be_status_ok
      json = JSON.parse(response.body)
	    expect(json.include?('tag')).to eq(true)
      tag = json['tag']
      expect(tag.include?('id')).to eq(true)
      expect(tag.include?('as')).to eq(true)
      expect(tag.include?('grouping')).to eq(true)
      expect(tag.include?('text')).to eq(true)
      expect(tag.include?('description')).to eq(true)
      expect(tag['as']).to eq('sports')
      expect(tag['grouping']).to eq('other')
      expect(tag['text']).to eq(mock_tag.name)
      expect(tag['description']).to eq('other')
    end

	  it 'returns forbidden when other users tag' do
      params = {
      	tag: {
          name: mock_tag.name,
          description: 'other'
      	}
      }.to_json
    	headers = merge_headers(
    		auth_header(user),
        content_type_header('application/json'),
    		accept_header('application/json')
    	)

      put "/api/v1/tags/#{other_tag.id}", params, headers

      expect(response.status).to be_status_forbidden
    end

	  it 'returns unauthorized when invalid user' do
      params = {
      	tag: {
          name: mock_tag.name,
          description: 'other'
      	}
      }.to_json
    	headers = merge_headers(
    		auth_header(invalid_user),
        content_type_header('application/json'),
    		accept_header('application/json')
    	)

      put "/api/v1/tags/#{tag1.id}", params, headers

      expect(response.status).to be_status_unauthorized
    end
  end # 'PUT /api/v1/tags/:id'

  # DELETE /api/v1/tags/:id
  describe 'DELETE /api/v1/tags/:id' do
    let!(:user) { create(:user) }
    let!(:team1) { create(:team) }
    let!(:tag1) { create(:tag, as: 'sports', for_type: team1.class.name, for_id: team1.id, grouping: 'other') }
    let!(:other_user) { create(:user) }
    let!(:other_team) { create(:team) }
    let!(:other_tag) { create(:tag, as: 'sports', for_type: other_team.class.name, for_id: other_team.id, grouping: 'other', user_id: other_user.id) }
    let!(:invalid_user) { nil }

    it 'returns tag array when with tags' do
    	headers = merge_headers(
    		auth_header(user),
    		accept_header('application/json')
    	)

      delete "/api/v1/tags/#{tag1.id}", nil, headers

      expect(response.status).to be_status_ok
      json = JSON.parse(response.body)
      expect(json.include?('tag')).to eq(true)
      tag = json['tag']
      expect(tag.include?('id')).to eq(true)
			expect(tag['id']).to eq(tag1.id)
			expect(Tag.exists?(tag['id'])).to eq(false)
    end

	  it 'returns forbidden when other users tag' do
    	headers = merge_headers(
    		auth_header(user),
    		accept_header('application/json')
    	)

      delete "/api/v1/tags/#{other_tag.id}", nil, headers

      expect(response.status).to be_status_forbidden
    end
    
	  it 'returns unauthorized when invalid user' do
    	headers = merge_headers(
    		auth_header(invalid_user),
    		accept_header('application/json')
    	)

      delete "/api/v1/tags/#{tag1.id}", nil, headers

      expect(response.status).to be_status_unauthorized
    end
  end # 'DELETE /api/v1/tags/:id'

end # V1::Tags