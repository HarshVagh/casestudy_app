class CasestudyUsersController < ApplicationController
    load_and_authorize_resource

    def index
        @assigned_casestudies = CasestudyUser.where(user_id: current_user.id).all
    end

    def new
        @casestudy_user = CasestudyUser.new
        @candidates = Role.find_by(name: "candidate").users.all
        @assessors = Role.find_by(name: "assessor").users.all
        @casestudies = Casestudy.where(contentcreator_id: current_user.id).all
    end

    def create
        @casestudy_user = CasestudyUser.new(casestudy_user_params)
        @casestudy_user.status = "pending"
        @casestudy_user.time_elaspsed = 0
        if @casestudy_user.save
            redirect_to new_casestudy_user_path
        else
            render :new, alert: "Error assigning casestudy"
        end
    end

    private
        def casestudy_user_params
            params.require(:casestudy_user).permit(:user_id, :assessor_id, :casestudy_id)
        end
    
    
end