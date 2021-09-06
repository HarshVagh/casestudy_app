class WalkInController < ApplicationController
    authorize_resource :class => false

    def new
        @casestudy_id = params[:casestudy_id]
        @assessor_id = params[:assessor_id]
    end

    def create
        new_walkin = WalkInAssessment.new(params[:casestudy_id], params[:assessor_id], params[:name], params[:email], params[:passkey])
        @casestudy_user = new_walkin.setup_assessment
        if @casestudy_user.id
            sign_in @casestudy_user.user
            redirect_to casestudy_user_instructions_path(@casestudy_user)
        else
            redirect_to new_walk_in_path(params[:casestudy_id], params[:assessor_id]), alert: "Error loading new assessment"
        end
    end


end