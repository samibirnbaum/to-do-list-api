require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do

    describe '#index' do
        context 'without authentication' do
            it 'has an http status response of unauthorised' do
                create(:user)
                get :index #this actually generates http request and get response
                expect(response).to have_http_status(401)
            end
        end

        context 'with authentication' do

            before do
                create(:user)
                request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials("SamiB","password")
            end
          
            it 'assigns all users to user variable' do
                get :index
                expect(assigns(:users)).to eq(User.all)
            end

            it 'returns all users as json in the http response body' do
                get :index
                json = JSON.parse(response.body) #get the response body in json format because this is what we expect to be returned
                expect(json[0]["email"]).to eq(User.all[0]["email"])
            end

            it 'doesnt return password in response body' do
                get :index
                json = JSON.parse(response.body)
                expect(json[0]["password"]).to eq(nil)
            end

            it 'has an http response of ok' do
                get :index
                expect(response).to have_http_status(200)
            end
        end
    end
end
