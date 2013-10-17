require 'q/review_request_queue'
require 'q/reviews'

class ReviewsPresenter
  attr_reader :queue, :reviews_submitted, :reviews_taken

  def initialize(user_id)
    @queue = Q::ReviewRequestQueue.for(user_id).peek

    reviews = Q::Reviews.for(user_id)
    @reviews_submitted = reviews.submitted
    @reviews_taken = reviews.taken
  end
end
