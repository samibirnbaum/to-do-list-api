class Api::UsersController < ApiController

    before_action :authenticated?, except: [:create]

    def index
        @users = User.all.reverse
        render json: @users, each_serializer: UserSerializer
    end

    def create
        @user = User.new
        @user.username = params["user"]["username"]
        @user.password = params["user"]["password"]
        @user.email = params["user"]["email"]

        if @user.save
            render json: @user
        else
            render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
    end
end
