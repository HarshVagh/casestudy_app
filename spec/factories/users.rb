FactoryBot.define do
    factory :user do

        name { "test user" }
        email { "testuser@g.c" }
        password { "12341234" }

        trait :user_candidate do
            name { "Candidate" }
            email { "candidate@g.c" }
            password { "12341234" }
        end

        trait :user_assessor do
            name { "Assessor" }
            email { "assessor@g.c" }
            password { "12341234" }
        end

        trait :user_contentcreator do
            name { "Content Creator" }
            email { "creator@g.c" }
            password { "12341234" }
        end

        trait :with_candidate_role do
            before(:create) do |user|
                create(:candidate_role) unless Role.all.exists?(name: "candidate")
            end
        end

        trait :with_assessor_role do
            after(:create) do |user|
                user.roles << FactoryBot.create(:assessor_role)
            end
        end

        trait :with_creator_role do
            after(:create) do |user|
                user.roles << FactoryBot.create(:contentcreator_role)
            end
        end

        factory :candidate, traits: [:user_candidate, :with_candidate_role]
        factory :assessor, traits: [:user_assessor, :with_assessor_role, :with_candidate_role]
        factory :contentcreator, traits: [:user_contentcreator, :with_creator_role, :with_candidate_role]
    end
end