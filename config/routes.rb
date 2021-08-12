Rails.application.routes.draw do
  devise_for :users
  # , controllers: {
  #   sessions: 'users/sessions'
  # }
  root to: "home#index"
  get 'candidate_dashboard', to: 'dashboard#candidate_dashboard', as: :candidate_dashboard
  get 'assessor_dashboard', to: 'dashboard#assessor_dashboard', as: :assessor_dashboard
  get 'admin_dashboard', to: 'dashboard#admin_dashboard', as: :admin_dashboard
end
