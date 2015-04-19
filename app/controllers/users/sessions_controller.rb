class Users::SessionsController < Devise::SessionsController
    def create
        resource = User.find_by_username(params[:username])
        if resource != nil
          if resource.valid_password?(params[:password])
            sign_in :user, resource

            render status: :ok, json: resource.player
          else
            render status: :forbidden, string: "Error" #nothing: true
          end
        else
          render status: :forbidden, nothing: true
      end
    end
end
