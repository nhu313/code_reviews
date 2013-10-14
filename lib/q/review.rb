require 'q/review_request_service'

module Q
  class Review
    attr_reader :request, :reply

    def self.for_request(request_id)
      Review.new(request_id)
    end

    private
    def initialize(request_id)
      @request = ReviewRequest.find(request_id)
      @reply = @request.reply
    end
  end
end
