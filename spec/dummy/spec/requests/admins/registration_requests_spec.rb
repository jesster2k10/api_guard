require 'dummy/spec/rails_helper'

describe 'Registration - Admin', type: :request do

  describe 'POST #create' do
    context 'with invalid params' do
      it 'should raise exception - missing param' do
        expect {
          post "/admins/sign_up"
        }.to raise_error ActionController::ParameterMissing
      end

      it 'should return 422 - email blank' do
        post "/admins/sign_up", params: { admin: attributes_for(:admin).except(:email) }

        expect(response).to have_http_status(422)
        expect(response_errors).to include("Email can't be blank")
      end
    end

    context 'with valid params' do
      it 'should create a new admin' do
        expect do
          post "/admins/sign_up", params: { admin: attributes_for(:admin) }
        end.to change(Admin, :count).by(1)

        expect(response).to have_http_status(200)
        expect(response_data['id']).to eq(Admin.last.id)
      end

      it 'should respond access token and refresh token in response headers' do
        post "/admins/sign_up", params: { admin: attributes_for(:admin) }

        expect(response).to have_http_status(200)
        expect(response.headers['Access-Token']).to be_present
        expect(response.headers['Expire-At']).to be_present
        expect(response.headers['Refresh-Token']).to be_present
      end
    end
  end
end
