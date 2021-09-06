FactoryBot.define do
    factory :casestudy_user do

        status { "pending" }
        time_elaspsed { 0 }
        casestudy_id { 1 }
        assessor_id { 2 }
        user_id { 3 }

        trait :casestudy_user_full do
            status { "pending" }
            time_elaspsed { 0 }
            casestudy factory: :complete_casestudy 
            assessor factory: :assessor
            user factory: :candidate
        end

        factory :complete_casestudy_user, traits: [:casestudy_user_full]
    end
end