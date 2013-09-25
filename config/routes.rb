CodeReview::Application.routes.draw do
  root :to => "reviews#index"

  # USER
  get "users/signout" => "users#destroy", :as => :signout
  get "auth/google_oauth2/callback" => "users#create"
  get "users/signin" => "users#signin", :as => :signin
  get "users/create_user" => "users#create"

  #REQUEST
  get "requests/new" => "review_requests#new", :as => :new_request
  get "requests/:id" => "review_requests#show", :as => :request
  post "requests" => "review_requests#create"

  #REVIEWS
  post "reviews/take_request/:review_request_id" => "reviews#take_request", :as => :take_request
  get "reviews/:id" => "reviews#show", :as => :review
  post "reviews" => "reviews#create"

end
