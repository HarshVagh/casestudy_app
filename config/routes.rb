Rails.application.routes.draw do
  
  root to: "home#index"
  devise_for :users

  get "candidate_dashboard", to: "dashboard#candidate_dashboard", as: :candidate_dashboard
  get "assessor_dashboard", to: "dashboard#assessor_dashboard", as: :assessor_dashboard
  get "contentcreator_dashboard", to: "dashboard#contentcreator_dashboard", as: :contentcreator_dashboard

  resources :role_users, only: [:new, :create, :destroy]
  resources :traits, only: [:new, :create]
  resources :casestudy_users, only: [:index, :new, :create] do
    resources :user_responses, only: [:index, :new, :create]
  end

  resources :casestudies, only: [:index, :new, :create, :show, :edit, :update] do
    resources :pages
    resources :questions do
      resources :question_traits, only: [:new, :create, :destroy]
    end
  end
end
