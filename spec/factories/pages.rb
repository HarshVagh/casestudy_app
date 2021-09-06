FactoryBot.define do
    factory :page do
        body { "This is body of a page in casestudy." }
        casestudy_id { 1 }
        
        trait :first_page do
            body { "This is body of a First page in casestudy." }
            casestudy_id { 1 }
        end

        trait :second_page do
            body { "This is body of a Second page in casestudy." }
            casestudy_id { 1 }
        end

        factory :page1, traits: [:first_page]
        factory :page2, traits: [:second_page]
    end
end