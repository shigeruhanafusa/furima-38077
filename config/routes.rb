Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"
  
  resources :items do
    collection do
      get 'search'
      get 'tag_search'
    end
    resources :comments, only: :create
  end
  resources :purchases, only: [:index, :create]
end
