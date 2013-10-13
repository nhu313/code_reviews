require 'q/reviews'

class HomepageController < ApplicationController

  def index
    reviews = Q::Reviews.for(user_id)
    @reviews_submitted = reviews.submitted
    @reviews_taken = reviews.taken
  end
end
