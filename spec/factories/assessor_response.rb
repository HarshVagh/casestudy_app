FactoryBot.define do
    factory :assessor_response do
        rating { 4.2 }
        question_trait_id { 1 }
        casestudy_user_id { 1 }
        user_id { 3 }
        assessor_id { 2 }
    end
end