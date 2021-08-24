class QuestionTraitsController < ApplicationController
    def new
        @question = Question.find(params[:question_id])
        @casestudy_id = @question.casestudy_id
        @traits_all = Trait.all
        @traits = @question.traits.all
        @trait = Trait.new
    end

    def create
        @question = Question.find(params[:question_id])
        @question_trait = @question.question_traits.create(trait_params)
        if @question_trait.save
            redirect_to new_casestudy_question_question_trait_path(casestudy_id: params[:casestudy_id], question_id: @question.id)
        end
    end

    def destroy
        @question_trait = QuestionTrait.where(question_id: params[:question_id], trait_id: params[:id]).first
        if @question_trait.destroy
            redirect_to new_casestudy_question_question_trait_path(casestudy_id: params[:casestudy_id], question_id: params[:question_id])
        end
    end

    private

        def trait_params
            params.require(:trait).permit(:trait_id)
        end
    
end