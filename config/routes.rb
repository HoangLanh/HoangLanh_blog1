Rails.application.routes.draw do
  devise_for :users
  root "posts#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resources :posts
  resources :posts, only: [:index, :show] do
    resources :comments, except: [:index, :show]
  end
  resources :users do
    get "/:relationship", on: :member,
      to: "relationships#index", as: :relationships
  end
  resources :relationships,       only: [:create,:index, :destroy]
end
