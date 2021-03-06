Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'lists#index'

  resources :lists, only: %i[index show new create edit update] do
    resources :bookmarks, only: %i[new create]
  end
  resources :bookmarks, only: [:destroy]
  resources :movies, only: %i[index show new create] do
    collection do
      get :result
      post :add, path: 'result'
    end
  end
end
