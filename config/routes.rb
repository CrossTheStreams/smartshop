Rails.application.routes.draw do
  root to: "home#index"

  get '/products' => "products#index", :as => :user_root

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  devise_scope :user do 
    get '/users/sign_out' => "users/sessions#destroy"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
