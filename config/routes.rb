CodeReview::Application.routes.draw do
  root :to => "reviews#index"
  get "users/signout" => "users#destroy", :as => :signout
  get "/auth/google_oauth2/callback" => "users#create"
  get "users/signin" => "users#signin", :as => :signin
  get "users/create_user" => "users#create"
  get "requests/new" => "requests#new"
end
