class PrepareAssessorResponse
    def initialize(casestudy_user, current_user_id)
      @casestudy_user = casestudy_user
      @current_user_id = current_user_id
    end

    def setup_responses
        if @casestudy_user.assessor_responses.size == 0
            @casestudy_user.casestudy.questions.each do |que|   
                que.question_traits.each do |qt|
                    @assessor_response = AssessorResponse.new
                    @assessor_response.question_trait_id = qt.id
                    @assessor_response.casestudy_user_id = @casestudy_user.id
                    @assessor_response.user_id = @casestudy_user.user.id
                    @assessor_response.assessor_id = @current_user_id
                    @assessor_response.rating = 0
                    @assessor_response.save
                end
            end
        end
    end
    
end