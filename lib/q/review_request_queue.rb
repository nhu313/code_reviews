require 'q/service_factory'

module Q
  class ReviewRequestQueue
    def self.for(user_id)
      ReviewRequestQueue.new(user_id)
    end

    def peek
      skipped_date = last_skipped_date
      request_db.find_all({:reviewer_id => nil}).detect do |r|
        r.user_id != user_id and r.posted_date > skipped_date
      end
    end

    def take_request(review_request_id)
      request_db.update(review_request_id, {:reviewer_id => user_id})
    end

    def skip_request(review_request_id)
      review_request_date = request_db.find_by_id(review_request_id).posted_date
      skipped_request = skipped_request_db.find_first({:user_id => user_id})

      if skipped_request
        skipped_request_db.update(skipped_request.id, {:last_skipped_date => review_request_date})
      else
        skipped_request_db.create({:user_id => user_id,
                                   :last_skipped_date => review_request_date})
      end
    end

    private
    attr_reader :user_id, :request_db, :skipped_request_db

    def initialize(user_id)
      @user_id = user_id
      @request_db = ServiceFactory.db_service(:review_request)
      @skipped_request_db = ServiceFactory.db_service(:skipped_review_request)
    end

    def last_skipped_date
      skipped_request = skipped_request_db.find_first({:user_id => user_id})
      return skipped_request.last_skipped_date if skipped_request
      DateTime.new
    end
  end
end
