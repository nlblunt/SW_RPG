class Gm::SessionsController < Devise::SessionsController
    def create
        resource = Gm.find_by_username(params[:username])
        
        if resource != nil
          if resource.valid_password?(params[:password])
            sign_in :gm, resource

            render status: :ok
          else
            render status: :forbidden, string: "Error" #nothing: true
          end
        else
          render status: :forbidden, nothing: true
      end
    end
end
