require 'q/db_service'

module Q
  class ReviewReplyService

    def initialize(user_id, model)
      @db_service = Q::DBService.new(model)
      @user_id = user_id
    end

    def find(review_id)
      db_service.find_by_id(review_id)
    end

    def user_replies
      db_service.find_all({:reviewer_id => user_id, :posted_date => nil})
    end

    def create_review(review_request_id)
      db_service.create({:reviewer_id => user_id,
                         :review_request_id => review_request_id})
    end

    def submit_reply(id, attributes)
      db_service.update(id, {
        :url => attributes[:url],
        :comment => attributes[:comment],
        :posted_date => DateTime.now
      })
    end

    private
    attr_reader :db_service, :user_id

  end
end
