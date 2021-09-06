class TraitsController < ApplicationController
    load_and_authorize_resource
    
    def new
        @trait = Trait.new
        @traits = Trait.all
    end

    def create
        @trait = Trait.new(trait_params)
        if @trait.save
            redirect_to new_trait_path
        else
            render :new, alert: "Error creating new trait"
        end
    end

    private

        def trait_params
            params.inspect
            params.require(:trait).permit(:name)
        end
    
end