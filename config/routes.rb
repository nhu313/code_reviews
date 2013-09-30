CodeReview::Application.routes.draw do
  root :to => "reviews#index"

  # USER
  get "users/signout" => "users#destroy", :as => :signout
  get "auth/google_oauth2/callback" => "users#create"
  get "users/signin" => "users#signin", :as => :signin
  get "users/create_user" => "users#create"

  #REQUEST
  get "review_requests/new" => "review_requests#new", :as => :new_review_request
  get "review_requests/:id" => "review_requests#show", :as => :review_request
  post "review_requests" => "review_requests#create"

  #REVIEWS
  get "reviews" => "reviews#index", :as => :reviews
  post "reviews/take_request/:review_request_id" => "reviews#take_request", :as => :take_request
  get "reviews/:id" => "reviews#show", :as => :review_reply
  get "reviews/:id/edit" => "reviews#edit", :as => :edit_review_reply
  patch "reviews/:id" => "reviews#submit_reply"

end
