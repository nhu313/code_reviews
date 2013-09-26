class ReviewsPresenter
  attr_reader :user_requests, :request_in_queue, :user_replies

  def initialize(user_id, request_service, reply_service)
    @user_requests = request_service.requests_for(user_id)
    @user_replies = reply_service.reviews_for(user_id)
    @request_in_queue = request_service.next_request_in_queue(user_id)
  end
end
