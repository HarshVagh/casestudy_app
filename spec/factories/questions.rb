FactoryBot.define do
    factory :question do
        body { "This is body of a question in casestudy." }
        casestudy_id { 1 }
        
        trait :first_question do
            body { "This is body of a First question in casestudy." }
            casestudy_id { 1 }
        end

        trait :second_question do
            body { "This is body of a Second question in casestudy." }
            casestudy_id { 1 }
        end

        trait :with_trait2 do
            after(:create) do |question|
                question.traits << create(:trait2)
            end
        end

        trait :with_trait3 do
            after(:create) do |question|
                question.traits << create(:trait3)
            end
        end

        factory :question1, traits: [:first_question, :with_trait2]
        factory :question2, traits: [:second_question, :with_trait3]
    end
end