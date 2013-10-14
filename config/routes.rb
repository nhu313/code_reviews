CodeReview::Application.routes.draw do
  root :to => "reviews#index"

  # USER
  get "users/signout" => "users#destroy", :as => :signout
  get "auth/google_oauth2/callback" => "users#create"
  get "users/signin" => "users#signin", :as => :signin
  get "users/create_user" => "users#create"

  #REQUEST
  get "review_requests" => "review_requests#index", :as => :review_requests
  get "review_requests/new" => "review_requests#new", :as => :new_review_request
  get "review_requests/:id" => "review_requests#show", :as => :review_request
  post "review_requests" => "review_requests#create"
  post "review_requests/:id/archive" => "review_requests#archive", :as => :archive_review_request

  #REVIEWS
  get "reviews/:review_request_id/take_request" => "reviews#take_request", :as => :take_request
  get "reviews/:review_request_id/skip_request" => "reviews#skip_request", :as => :skip_request
  get "reviews/:review_request_id" => "reviews#show", :as => :review

  get "review_replies/:review_request_id/new" => "review_replies#new", :as => :new_review_reply
  post "review_replies/:review_request_id" => "review_replies#create"
end
