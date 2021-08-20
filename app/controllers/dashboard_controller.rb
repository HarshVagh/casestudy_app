class DashboardController < ApplicationController
    authorize_resource :class => false
    def candidate_dashboard
        #authorize! :candidate_dashboard, :dashboard
    end

    def assessor_dashboard
        #authorize! :assessor_dashboard, :dashboard
    end

    def contentcreator_dashboard
        #authorize! :contentcreator_dashboard, :dashboard
    end
end