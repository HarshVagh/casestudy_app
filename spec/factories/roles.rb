FactoryBot.define do
    factory :role do

        trait :candidate do
            name { "candidate" }
        end

        trait :assessor do
            name { "assessor" }
        end

        trait :contentcreator do
            name { "contentcreator" }
        end

        factory :candidate_role, traits: [:candidate]
        factory :assessor_role, traits: [:assessor]
        factory :contentcreator_role, traits: [:contentcreator]
    end
end