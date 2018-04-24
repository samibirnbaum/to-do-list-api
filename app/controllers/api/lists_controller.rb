class Api::ListsController < ApiController
    before_action :authenticated?

    def create
        #we could put a permission function in here
        #to check that the user authenticating is creating a list for his user ID and no one elses
        @list = List.new
        @list.name = params["list"]["name"]
        @list.private = params["list"]["private"]
        @list.user_id = params["user_id"]

        if @list.save
            render json: @list
        else
            render json: { errors: @list.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update
        @list = List.find(params["id"])
        @list.name = params["list"]["name"]
        @list.private = params["list"]["private"]

        if @list.save
            render json: @list
        else
            render json: { errors: @list.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def destroy
        begin
            @list = List.find(params["id"])
            @list.destroy
            render json: {message: "The list '#{@list.name}' has been successfully deleted"}, status: :ok
        rescue ActiveRecord::RecordNotFound
            render json: {message: "this list does not exist in the database"}, status: :not_found 
        end
    end
end
