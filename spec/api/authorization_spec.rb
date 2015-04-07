# spec/api/authorization_spec.rb

require 'rails_helper'

describe V1::Authorization do
  subject { described_class }

  # POST /api/v1/authorize
  describe 'POST /api/v1/authorize' do
  	let!(:user) { create(:user) }

    it 'returns a token when valid username/password' do
      params = {
        username: user.username,
        password: 'secret'
      }.to_json
      headers = merge_headers(
        content_type_header('application/json'),
        accept_header('application/json')
      )

      post '/api/v1/authorize', params, headers

      expect(response.status).to be_status_created
      json = JSON.parse(response.body)
      expect(json.include?('token')).to eq(true)
      token = Token.new(encoded: json['token'])
      expect(token.valid?).to eq(true)
    end

    it 'returns an error when invalid username/password' do
      params = {
        username: user.username,
        password: 'xxxxxx'
      }.to_json
      headers = merge_headers(
        content_type_header('application/json'),
        accept_header('application/json')
      )

      post '/api/v1/authorize', params, headers

      expect(response.status).to be_status_unauthorized
      json = JSON.parse(response.body)
      expect(json.include?('error')).to eq(true)
      expect(json.include?('detail')).to eq(true)
      expect(json.include?('status')).to eq(true)
      error = json['error']
      detail = json['detail']
      status = json['status']
      expect(error).to eq("Unauthorized")
      expect(detail).to eq("Invalid username or password")
      expect(status).to eq("401")
    end
  end # 'POST /api/v1/authorize'

  # POST /api/v1/verify
  describe 'POST /api/v1/verify' do
    let!(:user) { create(:user) }

    it 'returns token verification details when given valid token' do
      token = user.generate_token.to_s
      params = {
        token: token
      }.to_json
      headers = merge_headers(
        content_type_header('application/json'),
        accept_header('application/json')
      )

      post '/api/v1/verify', params, headers

      expect(response.status).to be_status_created
      json = JSON.parse(response.body)
      expect(json.include?('token')).to eq(true)
      expect(json.include?('valid')).to eq(true)
      expect(json.include?('expires')).to eq(true)
      expect(json.include?('uid')).to eq(true)
      expect(json.include?('username')).to eq(true)
      return_token = json['token']
      valid = json['valid']
      expires = json['expires']
      uid = json['uid']
      username = json['username']
      expect(return_token).to eq(token)
      expect(valid).to eq(true)
      expect(expires).to eq(false)
      expect(uid).to eq(user.id)
      expect(username).to eq(user.username)
    end
   
    it 'returns token verification details when given expired token' do
      token = user.generate_token(expires: -Token.expires(15*60*1000)).to_s
      params = {
        token: token
      }.to_json
      headers = merge_headers(
        content_type_header('application/json'),
        accept_header('application/json')
      )

      post '/api/v1/verify', params, headers

      expect(response.status).to be_status_created
      json = JSON.parse(response.body)
      expect(json.include?('token')).to eq(true)
      expect(json.include?('valid')).to eq(true)
      expect(json.include?('expires')).to eq(true)
      expect(json.include?('uid')).to eq(true)
      return_token = json['token']
      valid = json['valid']
      expires = json['expires']
      uid = json['uid']
      username = json['username']
      expect(return_token).to eq(token)
      expect(valid).to eq(false)
      expect(expires).to eq(true)
      expect(uid).to eq(user.id)
    end

    it 'returns token verification details when given invalid token' do
      token = 'xxxxxx'
      params = {
        token: token
      }.to_json
      headers = merge_headers(
        content_type_header('application/json'),
        accept_header('application/json')
      )

      post '/api/v1/verify', params, headers

      expect(response.status).to be_status_created
      json = JSON.parse(response.body)
      expect(json.include?('token')).to eq(true)
      expect(json.include?('valid')).to eq(true)
      return_token = json['token']
      valid = json['valid']
      expect(return_token).to eq(token)
      expect(valid).to eq(false)
    end
  end # 'POST /api/v1/verify'

  # POST /api/v1/refresh
  describe 'POST /api/v1/refresh' do
    let!(:user) { create(:user) }

    it 'returns refreshed token when given valid token without expires' do
      token = user.generate_token.to_s
      params = {
        token: token
      }.to_json
      headers = merge_headers(
        content_type_header('application/json'),
        accept_header('application/json')
      )

      post '/api/v1/refresh', params, headers

      expect(response.status).to be_status_created
      json = JSON.parse(response.body)
      expect(json.include?('token')).to eq(true)
      token = Token.new(encoded: json['token'])
      expect(token.valid?).to eq(true)
    end

    it 'returns refreshed token when given valid token with expires' do
      token = user.generate_token(expires: Token.expires(15*60*1000)).to_s
      params = {
        token: token
      }.to_json
      headers = merge_headers(
        content_type_header('application/json'),
        accept_header('application/json')
      )

      post '/api/v1/refresh', params, headers

      expect(response.status).to be_status_created
      json = JSON.parse(response.body)
      expect(json.include?('token')).to eq(true)
      token = Token.new(encoded: json['token'])
      expect(token.valid?).to eq(true)
    end

    it 'returns unauthorized when given expired token' do
      token = user.generate_token(expires: -Token.expires(15*60*1000)).to_s
      params = {
        token: token
      }.to_json
      headers = merge_headers(
        content_type_header('application/json'),
        accept_header('application/json')
      )

      post '/api/v1/refresh', params, headers

      expect(response.status).to be_status_unauthorized
    end

    it 'returns unauthorized when given invalid token' do
      token = 'xxxxxx'
      params = {
        token: token
      }.to_json
      headers = merge_headers(
        content_type_header('application/json'),
        accept_header('application/json')
      )

      post '/api/v1/refresh', params, headers

      expect(response.status).to be_status_unauthorized
    end
  end # 'POST /api/v1/refresh'

end # V1::Authorization