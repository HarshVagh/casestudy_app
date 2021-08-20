class CasestudiesController < ApplicationController
    def new
        @casestudy = Casestudy.new
    end

    def create
        @casestudy = Casestudy.new(casestudy_params)
        @casestudy.contentcreator_id = current_user.id
        if @casestudy.save
            redirect_to casestudy_pages_path(@casestudy)
        end
    end

    private

        def casestudy_params
            params.require(:casestudy).permit(:name, :duration, :scale)
        end

end