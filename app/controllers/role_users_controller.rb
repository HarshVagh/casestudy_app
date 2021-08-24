class RoleUsersController < ApplicationController
    load_and_authorize_resource

    def new
        @users = User.all
        @roles = Role.all
        @role_user = RoleUser.new
    end

    def create
        @role_user = RoleUser.new(role_user_params)
        if @role_user.save
            redirect_to new_role_user_path
        end
    end

    private

        def role_user_params
            params.require(:role_user).permit(:user_id, :role_id)
        end

end