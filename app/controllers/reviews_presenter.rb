class ReviewsPresenter
  attr_reader :user_requests, :request_in_queue, :user_replies

  def initialize(request_service, reply_service)
    @user_replies = reply_service.user_replies

    @user_requests = request_service.user_requests
    @request_in_queue = request_service.next_request_in_queue
  end


end
