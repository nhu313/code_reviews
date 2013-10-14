require 'q/db_service'

module Q
  class ReviewRequestQueue
    def self.for(user_id)
      ReviewRequestQueue.new(user_id)
    end

    def peek
      # Needs to figure out how to say not
      request_db.find_all({:reviewer_id => nil}).first
    end

    private
    attr_reader :user_id, :request_db, :skipped_request_db

    def last_skip_request_id
      skip_request = skipped_request_db.find_first({:user_id => user_id})
      return skip_request.posted_date if skip_request
      return DateTime.new
    end

    def initialize(user_id)
      @user_id = user_id
      @request_db = DBService.create(:review_request)
      @skipped_request_db = DBService.create(:skipped_review_request)
    end



  end
end
