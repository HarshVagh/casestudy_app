class PrepareAssessment
    def initialize(casestudy_user, current_user_id)
        @casestudy_user = casestudy_user
        @current_user_id = current_user_id
    end

    def setup_responses
        if @casestudy_user.user_responses.size == 0
            @casestudy_user.casestudy.questions.all.each do |que|
                @user_response = UserResponse.new
                @user_response.casestudy_user_id = @casestudy_user.id
                @user_response.question_id = que.id
                @user_response.user_id = @current_user_id
                @user_response.response = ""
                @user_response.save
            end
        end
    end

    def create_submit_job
        AutoSubmitAssessmentJob.set(wait: 1.hour).perform_later(@casestudy_user.id)
    end

    def update_status
        @casestudy_user.status = "ongoing"
        @casestudy_user.started_time = DateTime.now
        @casestudy_user.save
    end

    def init_time_elapsed
        deadline  = @casestudy_user.started_time + 1.hour
        difference = (deadline - DateTime.now).to_i
        duration = @casestudy_user.casestudy.duration
        time_remaining = duration - @casestudy_user.time_elaspsed
        if  difference < time_remaining
            @casestudy_user.time_elaspsed = duration - difference
            @casestudy_user.save
        end
    end
    
end