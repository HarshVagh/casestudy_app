class UserResponsesController < ApplicationController
    before_action :set_casestudy_user, only: %i[ instructions assessment save_response submit_assessment update_time_elapsed ]
    respond_to :html, :json, only: [:update_time_elapsed]

    def instructions
    end
    
    def assessment
        if @casestudy_user.status == "pending"
            prepare_assessment = PrepareAssessment.new(@casestudy_user, current_user.id)
            prepare_assessment.setup_responses
            prepare_assessment.create_submit_job
            prepare_assessment.update_status  
            prepare_assessment.init_time_elapsed
        else
            prepare_assessment = PrepareAssessment.new(@casestudy_user, current_user.id).init_time_elapsed
        end
    end

    def save_response
        if @casestudy_user.status == "pending" || @casestudy_user.status == "ongoing"
            @user_response = UserResponse.find(user_response_params[:id])
            if @user_response.update(response: user_response_params[:response])
                redirect_to casestudy_user_assessment_path(params[:casestudy_user_id])
            end
        else
            redirect_to casestudy_user_submit_assessment_path(@casestudy_user.id)
        end
    end

    def submit_assessment
        if @casestudy_user.status == "ongoing"
            @casestudy_user.status = "completed"
            @casestudy_user.completed_time = DateTime.now
            @casestudy_user.save
        end
    end

    def update_time_elapsed
        @casestudy_user.time_elaspsed = params[:time_elaspsed]

        if @casestudy_user.status == "completed"
            @casestudy_user.time_elaspsed = @casestudy_user.casestudy.duration
        end
        
        if @casestudy_user.save             
            msg = {status: :ok, message: "Successfully updated time"}
            render json: msg
        else
            msg = {status: 500, message: "Internal Server error"}
            render json: msg
        end
    end

    private
        def set_casestudy_user
            @casestudy_user = CasestudyUser.find(params[:casestudy_user_id])
        end

        def update_time_elapsed_params
            params.permit(:casestudy_user_id, :time_elaspsed, :authenticity_token, :controller, :action)
        end

        def user_response_params
            params.require(:user_response).permit(:id, :response)
        end
    
end