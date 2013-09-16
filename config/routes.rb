CodeReview::Application.routes.draw do
  root :to => "reviews#index"
  get "sessions/signout" => "sessions#destroy", :as => :signout
  get "/auth/:provider/callback" => "sessions#create"
  get "sessions/signin" => "sessions#signin", :as => :signin
  get "/sessions/create_user" => "sessions#create"

end
