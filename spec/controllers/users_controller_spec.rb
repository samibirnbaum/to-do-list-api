require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do

    describe 'GET #index' do
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

    describe 'POST #create' do
        #no authentication to create an initial user
        it 'assigns the correct form data to the object' do
            post :create, params: {user: {username: "SamiB", email: "s@s.com", password: "password"}}
            expect(assigns(:user).username).to eq("SamiB")
            expect(assigns(:user).email).to eq("s@s.com")
            expect(assigns(:user).password).to eq("password")
        end
        it 'adds user to the database when form filled correclty' do
            expect {post :create, params: {user: {username: "SamiB", email: "s@s.com", password: "password"}}}.to change{User.all.count}.by(1)   
        end
        it 'returns new user as json' do
            post :create, params: {user: {username: "SamiB", email: "s@s.com", password: "password"}}
            json = JSON.parse(response.body)
            expect(json["username"]).to eq("SamiB")
            expect(json["password"]).to be_nil
        end
        it 'returns http 422 status when data filled incorrectly' do
            post :create, params: {user: {username: "", email: "", password: ""}}
            expect(response).to have_http_status(422)
        end
    
    end

    describe 'DELTE #destroy' do
        context 'without authentication' do
            it 'has an http status response of unauthorised' do
                create(:user)
                delete :destroy, params: {id: User.first.id}
                expect(response).to have_http_status(401)
            end
        end
        context 'with authentication' do
            before do
                create(:user)
                request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials("SamiB","password")
            end
            it 'assigns to @user the correct user from the params' do
                delete :destroy, params: {id: User.first.id}
                expect(assigns(:user).id).to eq(1)
            end
            it 'when successful user no longer exists' do
                delete :destroy, params: {id: User.first.id}
                expect(User.first).to be_nil
            end
            it 'when user cant be found to begin with returns error' do
                delete :destroy, params: {id: 2}
                expect(response).to have_http_status(404)
            end
        end
    end
end
