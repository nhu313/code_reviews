require 'q/db_service'

module Q
  class Reviews

    def self.for(user_id)
      Reviews.new(user_id)
    end

    def initialize(user_id)
      @user_id = user_id
      @request_db = DBService.create(:review_request)
      @reply_db = DBService.create(:review_reply)
    end

    def requested
      request_db.find_all({:user_id => user_id, :archive => false})
    end

    def taken
      reply_db.find_all({:reviewer_id => user_id, :posted_date => nil})
    end

    private
    attr_reader :user_id, :request_db, :reply_db

  end
end
