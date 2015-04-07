# spec/api/api_spec.rb

require 'rails_helper'

describe API do
  subject { described_class }

  # GET /
  describe 'GET /' do
    let!(:user) { create(:user) }
    let!(:invalid_user) { nil }

    it 'returns not found when valid user' do
      headers = merge_headers(
        auth_header(user),
        accept_header('application/json')
      )

      get '/', nil, headers

      expect(response.status).to eq(http_status(:not_found))
    end

    it 'returns unauthorized when invalid user' do
      headers = merge_headers(
        auth_header(invalid_user),
        accept_header('application/json')
      )

      get '/', nil, headers

      expect(response.status).to eq(http_status(:not_found))
    end
  end # 'GET /'

  # # GET /unmatched
  # describe 'GET /unmatched' do
  #   let!(:user) { create(:user) }
  #   let!(:invalid_user) { nil }

  #   it 'returns not found when valid user' do
  #     headers = merge_headers(
  #       auth_header(user),
  #       accept_header('application/json')
  #     )

  #     get '/unmatched', nil, headers

  #     expect(response.status).to eq(http_status(:not_found))
  #   end

  #   it 'returns unauthorized when invalid user' do
  #     headers = merge_headers(
  #       auth_header(invalid_user),
  #       accept_header('application/json')
  #     )

  #     get '/unmatched', nil, headers

  #     expect(response.status).to eq(http_status(:not_found))
  #   end
  # end # 'GET /unmatched'

  # Error formatter
  describe 'Error formatter' do
    let!(:user) { create(:user) }

    it 'returns internal server error with missing params' do
      params = {
      }.to_json
      headers = merge_headers(
        content_type_header('application/json'),
        accept_header('application/json')
      )

      post '/api/v1/authorize', params, headers

      expect(response.status).to eq(http_status(:internal_server_error))
      json = JSON.parse(response.body)
      expect(json.include?('error')).to eq(true)
      expect(json.include?('detail')).to eq(true)
      expect(json.include?('status')).to eq(true)
      expect(json['error']).to eq('Exception')
    end

  end # 'Error formatter'

end # API