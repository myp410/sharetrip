Rails.application.routes.draw do

devise_for :users, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
 
devise_for :admin,  skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  scope module: :public do
    root to: "homes#top"
    get 'about' => "homes#about", as: "about"
    get "users/my_page" => "users#show", as: "users_my_page"
    get "users/information/edit" => "users#edit", as: "users_information_edit"
    patch "users/information" => "users#update"
    get 'users/unsubscribe'
    patch 'users/withdraw'
    resources :posts, only:[:new, :index, :create, :show, :update, :edit, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
