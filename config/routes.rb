Rails.application.routes.draw do
  
  root to: "home#index"
  devise_for :users

  get "candidate_dashboard",      to: "dashboard#candidate_dashboard",      as: :candidate_dashboard
  get "assessor_dashboard",       to: "dashboard#assessor_dashboard",       as: :assessor_dashboard
  get "contentcreator_dashboard", to: "dashboard#contentcreator_dashboard", as: :contentcreator_dashboard

  get "walk_in/casestudies/:casestudy_id/users/:assessor_id",   to: "walk_in#new",    as: :new_walk_in
  post "walk_in/casestudies/:casestudy_id/users/:assessor_id",  to:"walk_in#create",  as: :create_walk_in

  resources :role_users, only: [:new, :create]
  resources :traits, only: [:new, :create]
  resources :casestudy_users, only: [:index, :new, :create] do
    get "/instructions",      to: "user_responses#instructions",      as: :instructions
    get "/assessment",        to: "user_responses#assessment",         as: :assessment
    patch "/save_response",   to: "user_responses#save_response",     as: :save_response
    get "/submit_assessment", to: "user_responses#submit_assessment",  as: :submit_assessment
  end

  get "assessor/:assessor_id/assessments", to: "assessor_responses#index", as: :assessor_response_index
  get "assessor/casestudy_user/:casestudy_user_id", to: "assessor_responses#assess", as: :assessor_response_assess
  patch "assessor/casestudy_user/:casestudy_user_id/update", to: "assessor_responses#update_rating", as: :assessor_response_update_rating
  get "assessor/casestudy_user/:casestudy_user_id/show", to: "assessor_responses#show", as: :show_assessor_response
  get "assessor/casestudy_user/:casestudy_user_id/submit", to: "assessor_responses#submit_assessment", as: :submit_assessor_response

  patch "/update_time" , to: "user_responses#update_time_elapsed"

  resources :casestudies, only: [:index, :new, :create, :show, :edit, :update] do
    resources :pages
    resources :questions do
      resources :question_traits, only: [:new, :create, :destroy]
    end
  end
  
end
