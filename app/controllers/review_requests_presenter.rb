class ReviewRequestsPresenter
  attr_reader :completed_requests, :taken_requests, :open_requests

  def initialize(user_requests)
    @completed_requests = extract_completed_requests(user_requests)
    @taken_requests = extract_taken_requests(user_requests)
    @open_requests = extract_open_requests(user_requests)
  end

  def extract_completed_requests(user_requests)
    user_requests.select {|r| r.completed? }
  end

  def extract_taken_requests(user_requests)
    user_requests.select {|r| r.taken? unless r.completed?}
  end

  def extract_open_requests(user_requests)
    user_requests.select {|r| !r.taken? }
  end
end
