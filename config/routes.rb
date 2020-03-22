Rails.application.routes.draw do
  namespace :admin do
    root to: 'rates#new'
    resources :rates, only: [:new, :create]
  end
  root to: 'rate#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
