Rails.application.routes.draw do
  root to: "articles#index"
  resources :articles, only: [:new, :create, :show] do
    resources :images, only: :create
  end
  resources :scraping, only: [:index, :update]
end
