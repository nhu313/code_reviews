CodeReview::Application.routes.draw do
  root :to => "reviews#index"

  # USER
  get "users/signout" => "users#destroy", :as => :signout
  get "auth/google_oauth2/callback" => "users#create"
  get "users/signin" => "users#signin", :as => :signin
  get "users/create_user" => "users#create"

  #REQUEST
  get "requests/new" => "requests#new", :as => :new_request
  get "requests/:id" => "requests#show", :as => :request
  post "requests" => "requests#create"

end
