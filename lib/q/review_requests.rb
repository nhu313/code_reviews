require 'q/services/factory'

module Q
  class ReviewRequests

    def self.for(user_id)
      ReviewRequests.new(user_id)
    end

    def completed
      review_requests.find_all {|r| r.completed? }
    end

    def taken
      review_requests.find_all {|r| r.taken? unless r.completed?}
    end

    def open
      review_requests.find_all {|r| !r.taken? }
    end

    private
    attr_reader :user_id, :review_requests

    def initialize(user_id)
      @user_id = user_id
      @review_requests = retrieve_requests
    end

    def retrieve_requests
      db = Services::Factory.db_service(:review_request)
      db.find_all({:user_id => user_id})
    end
  end
end
