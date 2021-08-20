class PagesController < ApplicationController
    #before_action :set_page, only %i[show edit ]
    def index
    end

    def new
        @page = Page.new
    end
    
    def create
        @page = Page.new(page_params)
        @page.casestudy_id = params[:casestudy_id]
        if @page.save
            redirect_to casestudy_pages_path(casestudy_id: params[:casestudy_id])
        end
    end

    private
        def set_page
            @page = Page.find(params[:id])
        end

        def page_params
            params.require(:page).permit(:body)
        end
end