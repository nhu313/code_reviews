require 'spec_helper'
require 'mocks/q/mock_review_request'

describe ReviewRequestsPresenter do
  attr_reader :presenter
  let(:open_requests) {build_open_requests(3)}
  let(:taken_requests) {build_taken_requests(2)}
  let(:completed_requests) {build_completed_requests(5)}

  before(:each) do
    user_requests = open_requests + taken_requests + completed_requests
    @presenter = ReviewRequestsPresenter.new(user_requests.shuffle)
  end

  it "has completed requests" do
    presenter.completed_requests.should =~ completed_requests
  end

  it "has taken requests" do
    presenter.taken_requests.should =~ taken_requests
  end

  it "has open requests" do
    presenter.open_requests.should =~ open_requests
  end

  def build_open_requests(size)
    (0...size).map do |i|
      review_request = MockReviewRequest.new(i)
      review_request.completed = false
      review_request.taken = false
      review_request
    end
  end

  def build_taken_requests(size)
    build_open_requests(size).each {|request| request.taken = true}
  end

  def build_completed_requests(size)
    build_taken_requests(size).each {|request| request.completed = true}
  end
end
