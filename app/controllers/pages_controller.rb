class PagesController < ApplicationController
    before_action :set_page, only: %i[ show edit update destroy ]

    def index
        @casestudy = Casestudy.find(params[:casestudy_id])
        @pages = Page.where(casestudy_id: params[:casestudy_id])
    end

    def new
        @page = Page.new
    end

    def show
    end
    
    def create
        @page = Page.new(page_params)
        @page.casestudy_id = params[:casestudy_id]
        if @page.save
            redirect_to casestudy_pages_path(casestudy_id: params[:casestudy_id])
        else
            render :new, alert: "Error creating new page"
        end
    end

    def edit
    end

    def update
        if @page.update(page_params)
            redirect_to casestudy_pages_path(casestudy_id: params[:casestudy_id])
        else
            render :edit, alert: "Error updating page"
        end
    end

    def destroy
        if @page.destroy
            redirect_to casestudy_pages_path(casestudy_id: params[:casestudy_id])
        else
            render :show, alert: "Error deleting page"
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