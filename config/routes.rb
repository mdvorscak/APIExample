Rails.application.routes.draw do
  resources :todo_lists


  namespace :api do
    resources :todo_lists do
      resources :todo_items, only: [:create, :update, :destroy]
    end
  end
end
