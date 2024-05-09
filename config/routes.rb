Rails.application.routes.draw do


devise_for :users, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

devise_scope :user do
  post "users/guest_sign_in" => "public/sessions#guest_sign_in"
end

devise_for :admin,  skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

get "search" => "public/searches#search"


  scope module: :public do
    root to: "homes#top"
    get 'about' => "homes#about", as: "about"
    get "users/my_page" => "users#show", as: "users_my_page"
    get "users/information/edit" => "users#edit", as: "users_information_edit"
    patch "users/information" => "users#update"
    get 'users/unsubscribe'
    patch 'users/withdraw'
    resources :posts, only:[:new, :index, :create, :show, :update, :edit, :destroy] do
      delete 'itineraries/destroy_all' => "itineraries#destroy_all"
      resources :itineraries, only: [:show, :create, :edit, :update, :destroy]
      resources :post_comments, only: [:index, :create, :edit, :update, :destroy]
    end
  end
  
  namespace :admin do 
    resources :users, only: [:index, :edit, :show, :update]
    resources :posts, only: [:index, :show, :destroy] do
      resources :post_comments, only: [:index, :destroy]
    end
  end 

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
