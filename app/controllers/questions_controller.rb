class QuestionsController < ApplicationController
    before_action :set_question, only: %i[ show edit update destroy ]

    def index
        @casestudy = Casestudy.find(params[:casestudy_id])
        @questions = Question.where(casestudy_id: params[:casestudy_id])
    end

    def new
        @question = Question.new
    end

    def edit
    end

    def show
    end
    
    def create
        @question = Question.new(question_params)
        @question.casestudy_id = params[:casestudy_id]
        if @question.save
            redirect_to new_casestudy_question_question_trait_path(casestudy_id: params[:casestudy_id], question_id: @question.id)
        end
    end

    def update
        if @question.update(question_params)
            redirect_to new_casestudy_question_question_trait_path(casestudy_id: params[:casestudy_id], question_id: @question.id)
        end
    end

    def destroy
        if QuestionTrait.where(question_id: @question.id).destroy_all
            if @question.destroy
                redirect_to casestudy_questions_path(casestudy_id: @question.casestudy_id)
            end
        end
    end

    private
        def set_question
            @question = Question.find(params[:id])
        end

        def question_params
            params.require(:question).permit(:body)
        end
    
    
end