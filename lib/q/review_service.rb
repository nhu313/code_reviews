module Q
  class ReviewService

    def initialize(user_id, request_service, reply_service)
      @user_id = user_id
    end

    def user_requests

    end

    def next_request_in_queue

    end

    def user_replies

    end

    private
    attr_reader :user_id
  end
end
