class QuestionsController < ApplicationController
    def index
        
    end

    def new
        @question = Question.new
    end
    
    def create
        @question = Question.new(question_params)
        @question.casestudy_id = params[:casestudy_id]
        if @question.save
            redirect_to new_casestudy_question_question_trait_path(casestudy_id: params[:casestudy_id], question_id: @question.id)
        end
    end

    private

        def question_params
            params.require(:question).permit(:body)
        end
    
    
end