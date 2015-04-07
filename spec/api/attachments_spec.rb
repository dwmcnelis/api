# spec/api/attachments_spec.rb

require 'rails_helper'

describe V1::Attachments do
  subject { described_class }

  # POST /api/v1/attachments
  describe 'POST /api/v1/attachments' do
  	let!(:user) { create(:user) }
  	let!(:client1) { create(:client, user_id: user.id) }
  	let!(:invalid_user) { nil }

    it 'creates attachment' do
      boundary = '----WebKitFormBoundarygQTDWB9pzKsRPDMr'
      body = attachment_body(boundary,'26008ca7-7d8d-443e-b92e-89db63dbe9cf','file.png',client1.class.name,client1.id,'image')
    	headers = merge_headers(
    		auth_header(user),
        content_type_header("multipart/form-data; boundary=#{boundary}"),
        content_length_header(body.length),
    		accept_header('application/json')
    	)

      post '/api/v1/attachments', body, headers

      expect(response.status).to be_status_created
      json = JSON.parse(response.body)
	    expect(json.include?('attachment')).to eq(true)
      attachment = json['attachment']
      expect(attachment.include?('content')).to eq(true)
      expect(attachment.include?('name')).to eq(true)
      expect(attachment.include?('mime_type')).to eq(true)
      expect(attachment.include?('size')).to eq(true)
      expect(attachment.include?('url')).to eq(true)
      expect(attachment.include?('for_type')).to eq(true)
      expect(attachment.include?('for_id')).to eq(true)
      expect(attachment.include?('for_attribute')).to eq(true)
			expect(attachment['name']).to eq('file.png')
			expect(attachment['size']).to eq(1055)
			expect(attachment['for_type']).to eq(client1.class.name)
			expect(attachment['for_id']).to eq(client1.id)
			expect(attachment['for_attribute']).to eq('image')
    end

	  it 'returns unauthorized when invalid user' do
      boundary = '----WebKitFormBoundarygQTDWB9pzKsRPDMr'
      body = attachment_body(boundary,'26008ca7-7d8d-443e-b92e-89db63dbe9cf','file.png',client1.class.name,client1.id,'image')
    	headers = merge_headers(
    		auth_header(invalid_user),
        content_type_header("multipart/form-data; boundary=#{boundary}"),
        content_length_header(body.length),
    		accept_header('application/json')
    	)

      post '/api/v1/attachments', body, headers

      expect(response.status).to be_status_unauthorized
    end
  end # 'POST /api/v1/attachments'

end # V1::Attachments
