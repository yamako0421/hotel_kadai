Rails.application.routes.draw do
  root to: 'pages#index'
  
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  
  resources :users
  resources :reservations
  resources :rooms do
    collection do
      get 'search'
    end
  end

  # ActiveStorageのルートをマウント
Rails.application.routes.draw do
  mount ActiveStorage::Engine => '/rails/active_storage'
end
end
