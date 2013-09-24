class ReviewsPresenter
  attr_reader :requests, :request_in_queue

  def initialize(request_service, user_id)
    @request_service = request_service
    @requests = request_service.requests_for(user_id)
    @request_in_queue = request_service.next_request_in_queue(user_id)
  end

  def request_in_queue_title
    request_in_queue.title
  end

  def request_in_queue_description
    request_in_queue.description
  end
end
