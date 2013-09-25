class ReviewsPresenter
  attr_reader :user_requests, :request_in_queue, :user_replies

  def initialize(user_id, review_service)
    @user_requests = review_service.user_requests
    @user_replies = review_service.user_replies
    @request_in_queue = review_service.next_request_in_queue
  end

  def request_in_queue_title
    request_in_queue.title
  end

  def request_in_queue_description
    request_in_queue.description
  end

end
