Rails.application.routes.draw do

  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_scope :user do
    post "users/guest_sign_in" => "public/sessions#guest_sign_in"
  end

  devise_for :admin,  skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
  scope module: :public do
    root to: "homes#top"
    get "search" => "searches#search"
    get "search_tag" => "posts#search_tag"
    get "privacy" => "homes#privacy", as: "privacy"
    get "users/my_page/:id" => "users#show", as: "users_my_page"
    get "users/information/edit" => "users#edit", as: "users_information_edit"
    patch "users/information" => "users#update"
    get "users/unsubscribe"
    patch "users/withdraw"
    resources :users, only: [] do
      resources :relationships, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
    end
    post "/post/:post_id/items/:id/toggle" => "items#toggle"
    resources :posts, only: [:index, :create, :show, :update, :destroy] do
      delete "itineraries/destroy_all" => "itineraries#destroy_all"
      resources :itineraries, only: [:show, :create, :update, :destroy] do
        resources :articles, only: [:create, :destroy]
        resources :prices, only: [:create, :destroy]
      end
      resources :post_comments, only: [:index, :create, :update, :destroy]
      resource :favorites, only: [:create, :destroy] # urlにID含めない
      resources :items, only: [:index, :create, :destroy]
    end
    # グループ一覧の表示
    get "groups/:id/permits" => "groups#permits", as: "permits"
    delete "groups/:group_id/permits/:id/cancel_request" => "permits#cancel_request", as: "cancel_request"
    resources :groups, only: [:index, :show, :create, :update, :destroy] do
      resource :group_users, only: [:create, :destroy]
      resource :permits, only: [:create, :destroy]
      resource :rooms, only: [:show, :create] do
        resources :messages, only: [:create]
      end
    end
    resources :notifications, only: [:update]

    post "contacts/confirm" => "contacts#confirm", as: "confirm"
    get "contacts/confirm", to: "contacts#error", as: "error"
    post "contacts/back" => "contacts#back", as: "back"
    get "done" => "contacts#done", as: "done"
    resources :contacts, only: [:create]
  end

  namespace :admin do
    get "search" => "searches#search"
    resources :users, only: [:index, :edit, :show, :update]
    resources :posts, only: [:index, :show, :destroy] do
      resources :post_comments, only: [:index, :destroy]
    end
    resources :groups, only: [:index, :show, :edit, :update, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
