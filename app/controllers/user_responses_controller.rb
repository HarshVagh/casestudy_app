class UserResponsesController < ApplicationController
    def index
        @casestudy_user = CasestudyUser.find(params[:casestudy_user_id])
        if @casestudy_user.user_responses.size == 0
            @casestudy_user.casestudy.questions.all.each do |que|
                @user_response = UserResponse.new
                @user_response.casestudy_user_id = @casestudy_user.id
                @user_response.question_id = que.id
                @user_response.user_id = current_user.id
                @user_response.response = ""
                @user_response.save
            end
        end
    end
    
    def new
        @casestudy_user = CasestudyUser.find(params[:casestudy_user_id])
    end

    def create
        @user_response = UserResponse.find(params[:user_response][:id])
        if @user_response.update(response: params[:user_response][:response])
            redirect_to new_casestudy_user_user_response_path(params[:casestudy_user_id])
        end
    end
    
end