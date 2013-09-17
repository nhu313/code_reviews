CodeReview::Application.routes.draw do
  root :to => "reviews#index"
  get "users/signout" => "users#destroy", :as => :signout
  get "/auth/:provider/callback" => "users#create"
  get "users/signin" => "users#signin", :as => :signin
  get "/users/create_user" => "users#create"

end
