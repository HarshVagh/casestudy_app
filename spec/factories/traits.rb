FactoryBot.define do
    factory :trait1, class: "Trait" do

        name { "Trait01" }

        trait :trait_second do
            name { "Trait02" }
        end

        trait :trait_third do
            name { "Trait03" }
        end

        factory :trait2, traits: [:trait_second]
        factory :trait3, traits: [:trait_third]
    end
end