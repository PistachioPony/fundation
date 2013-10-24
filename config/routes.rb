Fundation::Application.routes.draw do
  root 'welcome#index'

  resources :users, except: [:index, :destroy] do
    resources :watchlists, except: [:index, :edit, :update, :destroy] do
    end
    member do
        patch "append_to_watchlist"
    end
  end

  resources :companies, only: [:show] do
    collection do
      get "search"
      get "query"
      get "results"
    end
  end

  resource :session, only: [:new, :create, :destroy]
end
