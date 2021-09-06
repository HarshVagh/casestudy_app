FactoryBot.define do
    factory :user_response do
        response { "This is a response for a question in casestudy." }
        question_id { 1 }
        casestudy_user_id { 1 }
        user_id { 3 }
    end
end