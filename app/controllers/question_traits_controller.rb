class QuestionTraitsController < ApplicationController
    def new
        @question = Question.find(params[:question_id])
        @traits = Trait.all
        @trait = Trait.new
    end

    def create
        @question = Question.find(params[:question_id])
        @question_trait = @question.question_traits.create(trait_params)
        if @question_trait.save
            redirect_to new_casestudy_question_question_trait_path(casestudy_id: params[:casestudy_id], question_id: @question.id)
        end
    end

    private

        def trait_params
            params.require(:trait).permit(:trait_id)
        end
    
end