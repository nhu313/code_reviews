class ReviewsPresenter
  attr_accessor :service
  attr_reader :requests, :request_in_queue

  def initialize(service, user_id)
    @service = service
    @requests = service.requests_for(user_id)
    @request_in_queue = service.next_request_in_queue(user_id)
  end
end
