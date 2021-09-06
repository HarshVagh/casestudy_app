class CasestudiesController < ApplicationController
    load_and_authorize_resource
    before_action :set_casestudy, only: %i[ show edit update ]

    def index
        @casestudies = Casestudy.where(contentcreator_id: current_user.id)
    end
    
    def new
        @casestudy = Casestudy.new
    end

    def edit
    end

    def show
    end

    def create
        @casestudy = Casestudy.new(casestudy_params)
        @casestudy.contentcreator_id = current_user.id
        if @casestudy.save
            redirect_to casestudy_pages_path(@casestudy)
        else
            render :new, alert: "Error creating new casestudy"
        end
    end

    def update
        if @casestudy.update(casestudy_params)
            redirect_to casestudy_pages_path(@casestudy)
        else
            render :edit, alert: "Error updating casestudy"
        end
    end

    private
        def set_casestudy
            @casestudy = Casestudy.find(params[:id])
        end

        def casestudy_params
            params.require(:casestudy).permit(:name, :duration, :scale, :passkey)
        end

end