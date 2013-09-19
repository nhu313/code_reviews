CodeReview::Application.routes.draw do
  root :to => "reviews#index"
  get "users/signout" => "users#destroy", :as => :signout
  match "/auth/google_oauth2/callback" => "users#create", via: [:get]
  get "users/signin" => "users#signin", :as => :signin
  get "/users/create_user" => "users#create"
end
