require 'rails_helper'

RSpec.describe Api::V1::AccessKeysController, type: :request do
  let(:user) { create(:user) }
  let(:access_key) { user.access_keys.first }

  let(:headers) do
    token = access_key.token
    auth_token = access_key.auth_token
    { 'HTTP_AUTHORIZATION': basic_auth(token, auth_token) }
  end

  describe 'GET /api/v1/access_keys' do
    it 'returns access key list' do
      user.access_keys.create
      get '/api/v1/access_keys', headers: headers
      expect(json).to include_json(access_keys: [])
    end
  end

  describe 'GET /api/v1/access_keys/count' do
    it 'counts access keys' do
      user.access_keys.create
      get '/api/v1/access_keys/count', headers: headers
      expect(json).to include_json(count: 2)
    end
  end
end
