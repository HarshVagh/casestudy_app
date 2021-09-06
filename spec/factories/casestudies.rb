FactoryBot.define do
    factory :casestudy do

        name { "casestudy01" }
        duration { 90 }
        scale { 8 }
        contentcreator_id { 1 }
        passkey { "12341234" }

        trait :casestudy_with_creator do
            name { "casestudy01" }
            duration { 90 }
            scale { 8 }
            contentcreator
            passkey { "12341234" }
        end

        trait :with_pages do
            after(:create) do |casestudy|
                create(:page)
                create(:page1)
                create(:page2)
            end
        end

        trait :with_questions do
            after(:create) do |casestudy|
                create(:question1)
                create(:question2)
            end
        end

        factory :complete_casestudy, traits: [:casestudy_with_creator, :with_pages, :with_questions]
        factory :casestudy_creator, traits: [:casestudy_with_creator]
    end
end