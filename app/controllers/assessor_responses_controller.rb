class AssessorResponsesController < ApplicationController
    load_and_authorize_resource
    before_action :set_casestudy_user, only: %i[ assess show update_rating submit_assessment ]

    def index
        @casestudy_users = CasestudyUser.where(assessor_id: params[:assessor_id])
    end

    def assess
        if @casestudy_user.status == "completed"
            PrepareAssessorResponse.new(@casestudy_user, current_user.id).setup_responses
        else
            redirect_to show_assessor_response_path(@casestudy_user)
        end
        
    end

    def show
    end

    def update_rating
        @assessor_response = AssessorResponse.where(casestudy_user_id: @casestudy_user.id).find_by(question_trait_id: update_rating_params[:question_trait_id])
        if @assessor_response.update(rating: update_rating_params[:rating])
            redirect_to assessor_response_assess_path(@casestudy_user)
        end
    end

    def submit_assessment
        if @casestudy_user.status == "completed"
            @casestudy_user.update(status: "assessed")
            redirect_to assessor_response_index_path(current_user.id)
        end
    end

    private

        def set_casestudy_user
            @casestudy_user = CasestudyUser.find(params[:casestudy_user_id])
        end 

        def update_rating_params
            params.require(:assessor_response).permit(:question_trait_id, :rating)
        end
end