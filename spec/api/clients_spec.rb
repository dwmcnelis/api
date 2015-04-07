# spec/api/clients_spec.rb

require 'rails_helper'

describe V1::Clients do
  subject { described_class }

  # GET /api/v1/clients
  describe 'GET /api/v1/clients' do
  	let!(:with_client_user) { create(:user) }
  	let!(:client1) { create(:client, user_id: with_client_user.id) }
  	let!(:client2) { create(:client, user_id: with_client_user.id) }
  	let!(:client3) { create(:client, user_id: with_client_user.id) }
  	let!(:without_client_user) { create(:user) }
  	let!(:invalid_user) { nil }

    it 'returns client array when with clients' do
      headers = merge_headers(
        auth_header(with_client_user),
        accept_header('application/json')
      )

      get '/api/v1/clients', nil, headers

      expect(response.status).to be_status_ok
      json = JSON.parse(response.body)
      expect(json.include?('clients')).to eq(true)
      clients = json['clients']
      expect(clients.count).to eq(3)
      expect(clients.map{|e| e['id']}.sort).to eq([client1.id, client2.id, client3.id].sort)
    end

    it 'returns paginated client array when with clients' do
      headers = merge_headers(
        auth_header(with_client_user),
        accept_header('application/json')
      )

      get '/api/v1/clients?per_page=1', nil, headers

      expect(response.status).to be_status_ok
      json = JSON.parse(response.body)
      expect(json.include?('clients')).to eq(true)
      clients = json['clients']
      expect(clients.count).to eq(1)
      expect([client1.id, client2.id, client3.id].include?(clients.first['id'])).to eq(true)
    end

    it 'returns an empty array when without clients' do
    	headers = merge_headers(
    		auth_header(without_client_user),
    		accept_header('application/json')
    	)

      get '/api/v1/clients', nil, headers

      expect(response.status).to be_status_ok
      json = JSON.parse(response.body)
      expect(json.include?('clients')).to eq(true)
      clients = json['clients']
      expect(clients).to eq([])
    end

	  it 'returns unauthorized when invalid user' do
    	headers = merge_headers(
    		auth_header(invalid_user),
    		accept_header('application/json')
    	)

      get '/api/v1/clients', nil, headers

      expect(response.status).to be_status_unauthorized
    end
  end # 'GET /api/v1/clients'

  # GET /api/v1/clients/:id
  describe 'GET /api/v1/clients/:id' do
  	let!(:with_client_user) { create(:user) }
  	let!(:client1) { create(:client, user_id: with_client_user.id) }
  	let!(:invalid_user) { nil }

    it 'returns client' do
    	headers = merge_headers(
    		auth_header(with_client_user),
    		accept_header('application/json')
    	)

      get "/api/v1/clients/#{client1.id}", nil, headers

      expect(response.status).to be_status_ok
      json = JSON.parse(response.body)
	    expect(json.include?('client')).to eq(true)
      client = json['client']
      expect(client.include?('id')).to eq(true)
      expect(client.include?('first_name')).to eq(true)
      expect(client.include?('last_name')).to eq(true)
      expect(client.include?('email')).to eq(true)
      expect(client.include?('phone')).to eq(true)
      expect(client.include?('level')).to eq(true)
      expect(client.include?('rank')).to eq(true)
      expect(client.include?('status')).to eq(true)
      expect(client.include?('buzzes')).to eq(true)
      expect(client.include?('notes')).to eq(true)
			expect(client['id']).to eq(client1.id)
			expect(client['first_name']).to eq(client1.first_name)
			expect(client['last_name']).to eq(client1.last_name)
			expect(client['email']).to eq(client1.email)
			expect(client['phone']).to eq(client1.phone)
			expect(client['level']).to eq(client1.level)
			expect(client['rank']).to eq(client1.rank)
			expect(client['status']).to eq(client1.status)
			expect(client['buzzes']).to eq(client1.buzzes)
			expect(client['notes']).to eq(client1.notes)
    end

	  it 'returns unauthorized when invalid user' do
    	headers = merge_headers(
    		auth_header(invalid_user),
    		accept_header('application/json')
    	)

      get "/api/v1/clients/#{client1.id}", nil, headers

      expect(response.status).to be_status_unauthorized
    end
  end # 'GET /api/v1/clients/:id'

  # POST /api/v1/clients
  describe 'POST /api/v1/clients' do
  	let!(:without_client_user) { create(:user) }
  	let!(:invalid_user) { nil }
  	let!(:mock_client) { create(:client) }

    it 'creates client' do
      params = {
      	client: {
	        first_name: mock_client.first_name,
	        last_name: mock_client.last_name,
	        email: mock_client.email,
	        phone: mock_client.phone,
	        level: mock_client.level,
	        rank: mock_client.rank,
	        status: mock_client.status,
	        buzzes: mock_client.buzzes,
	        notes: mock_client.notes
      	}
      }.to_json
    	headers = merge_headers(
    		auth_header(without_client_user),
        content_type_header('application/json'),
    		accept_header('application/json')
    	)

      post '/api/v1/clients', params, headers

      expect(response.status).to be_status_created
      json = JSON.parse(response.body)
	    expect(json.include?('client')).to eq(true)
      client = json['client']
      expect(client.include?('id')).to eq(true)
      expect(client.include?('first_name')).to eq(true)
      expect(client.include?('last_name')).to eq(true)
      expect(client.include?('email')).to eq(true)
      expect(client.include?('phone')).to eq(true)
      expect(client.include?('level')).to eq(true)
      expect(client.include?('rank')).to eq(true)
      expect(client.include?('status')).to eq(true)
      expect(client.include?('buzzes')).to eq(true)
      expect(client.include?('notes')).to eq(true)
			expect(client['first_name']).to eq(mock_client.first_name)
			expect(client['last_name']).to eq(mock_client.last_name)
			expect(client['email']).to eq(mock_client.email)
			expect(client['phone']).to eq(mock_client.phone)
			expect(client['level']).to eq(mock_client.level)
			expect(client['rank']).to eq(mock_client.rank)
			expect(client['status']).to eq(mock_client.status)
			expect(client['buzzes']).to eq(mock_client.buzzes)
			expect(client['notes']).to eq(mock_client.notes)
    end

	  it 'returns unauthorized when invalid user' do
      params = {
      	client: {
	        first_name: mock_client.first_name,
	        last_name: mock_client.last_name,
	        email: mock_client.email,
	        phone: mock_client.phone,
	        level: mock_client.level,
	        rank: mock_client.rank,
	        status: mock_client.status,
	        buzzes: mock_client.buzzes,
	        notes: mock_client.notes
      	}
      }.to_json
    	headers = merge_headers(
    		auth_header(invalid_user),
        content_type_header('application/json'),
    		accept_header('application/json')
    	)

      post '/api/v1/clients', params, headers

      expect(response.status).to be_status_unauthorized
    end
  end # 'POST /api/v1/clients'

  # PUT /api/v1/clients/:id
  describe 'PUT /api/v1/clients/:id' do
  	let!(:with_client_user) { create(:user) }
  	let!(:client1) { create(:client, user_id: with_client_user.id) }
   	let!(:other_client_user) { create(:user) }
  	let!(:client4) { create(:client, user_id: other_client_user.id) }
 		let!(:invalid_user) { nil }
  	let!(:mock_client) { create(:client) }

    it 'updates client' do
      params = {
      	client: {
	        first_name: mock_client.first_name,
	        last_name: mock_client.last_name,
	        email: mock_client.email,
      	}
      }.to_json
    	headers = merge_headers(
    		auth_header(with_client_user),
        content_type_header('application/json'),
    		accept_header('application/json')
    	)

      put "/api/v1/clients/#{client1.id}", params, headers

      expect(response.status).to be_status_ok
      json = JSON.parse(response.body)
	    expect(json.include?('client')).to eq(true)
      client = json['client']
      expect(client.include?('id')).to eq(true)
      expect(client.include?('first_name')).to eq(true)
      expect(client.include?('last_name')).to eq(true)
      expect(client.include?('email')).to eq(true)
      expect(client.include?('phone')).to eq(true)
      expect(client.include?('level')).to eq(true)
      expect(client.include?('rank')).to eq(true)
      expect(client.include?('status')).to eq(true)
      expect(client.include?('buzzes')).to eq(true)
      expect(client.include?('notes')).to eq(true)
			expect(client['first_name']).to eq(mock_client.first_name)
			expect(client['last_name']).to eq(mock_client.last_name)
			expect(client['email']).to eq(mock_client.email)
			expect(client['phone']).to eq(client1.phone)
			expect(client['level']).to eq(client1.level)
			expect(client['rank']).to eq(client1.rank)
			expect(client['status']).to eq(client1.status)
			expect(client['buzzes']).to eq(client1.buzzes)
			expect(client['notes']).to eq(client1.notes)
    end

	  it 'returns unauthorized when other users client' do
      params = {
      	client: {
	        first_name: mock_client.first_name,
	        last_name: mock_client.last_name,
	        email: mock_client.email,
      	}
      }.to_json
    	headers = merge_headers(
    		auth_header(invalid_user),
        content_type_header('application/json'),
    		accept_header('application/json')
    	)

      put "/api/v1/clients/#{client4.id}", params, headers

      expect(response.status).to be_status_unauthorized
    end

	  it 'returns unauthorized when invalid user' do
      params = {
      	client: {
	        first_name: mock_client.first_name,
	        last_name: mock_client.last_name,
	        email: mock_client.email,
      	}
      }.to_json
    	headers = merge_headers(
    		auth_header(invalid_user),
        content_type_header('application/json'),
    		accept_header('application/json')
    	)

      put "/api/v1/clients/#{client1.id}", params, headers

      expect(response.status).to be_status_unauthorized
    end
  end # 'PUT /api/v1/clients/:id'

  # DELETE /api/v1/clients/:id
  describe 'DELETE /api/v1/clients/:id' do
  	let!(:with_client_user) { create(:user) }
  	let!(:client1) { create(:client, user_id: with_client_user.id) }
   	let!(:other_client_user) { create(:user) }
  	let!(:client4) { create(:client, user_id: other_client_user.id) }
 		let!(:invalid_user) { nil }

    it 'returns client array when with clients' do
    	headers = merge_headers(
    		auth_header(with_client_user),
    		accept_header('application/json')
    	)

      delete "/api/v1/clients/#{client1.id}", nil, headers

      expect(response.status).to be_status_ok
      json = JSON.parse(response.body)
      expect(json.include?('client')).to eq(true)
      client = json['client']
      expect(client.include?('id')).to eq(true)
			expect(client['id']).to eq(client1.id)
			expect(Client.exists?(client['id'])).to eq(false)
    end

	  it 'returns unauthorized when other users client' do
    	headers = merge_headers(
    		auth_header(invalid_user),
    		accept_header('application/json')
    	)

      delete "/api/v1/clients/#{client4.id}", nil, headers

      expect(response.status).to be_status_unauthorized
    end
    
	  it 'returns unauthorized when invalid user' do
    	headers = merge_headers(
    		auth_header(invalid_user),
    		accept_header('application/json')
    	)

      delete "/api/v1/clients/#{client1.id}", nil, headers

      expect(response.status).to be_status_unauthorized
    end
  end # 'DELETE /api/v1/clients/:id'

end # V1::Clients