Rails.application.routes.draw do
  
  root to: "home#index"
  devise_for :users

  get "candidate_dashboard", to: "dashboard#candidate_dashboard", as: :candidate_dashboard
  get "assessor_dashboard", to: "dashboard#assessor_dashboard", as: :assessor_dashboard
  get "contentcreator_dashboard", to: "dashboard#contentcreator_dashboard", as: :contentcreator_dashboard
  
  # resources :casestudies do
  #   get "index_page", to: "casestudies#index_page", as: :index_page
  #   get "new_page", to: "casestudies#new_page", as: :new_page
  #   post "create_page", to: "casestudies#create_page", as: :create_page

  #   get "index_question", to: "casestudies#index_question", as: :index_question
  #   get "new_question", to: "casestudies#new_question", as: :new_question
  #   post "create_question", to: "casestudies#create_question", as: :create_question
  #   get "index_question/:question_id/add_trait_question", to: "casestudies#add_trait_question", as: :add_trait_question
  #   post "index_question/:question_id/create_trait_question", to: "casestudies#create_trait_question", as: :create_trait_question
  # end


  resources :casestudies do
    resources :pages, only: [:index, :new, :create]
    resources :questions, only: [:index, :new, :create] do
      resources :question_traits, only: [:new, :create]
    end
  end
end
