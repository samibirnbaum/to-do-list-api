class ApiController < ApplicationController
    #dont want to use rails default csrf session system because we wont have token in the html
    #automatically not included in rails api mode
    # skip_before_action :verify_authenticity_token 

    #we will create our own authentication for users
    private
    def authenticated?
        #there is no session every http request the user has to authenticate again - stateless http
        #the method below will obtain the username and password and see if it exists in the database
        authenticate_or_request_with_http_basic{|username, password| User.where( username: username, password: password).present? }
        #note the password in the databse would normally be hashed so would have to work with that
    end
end
