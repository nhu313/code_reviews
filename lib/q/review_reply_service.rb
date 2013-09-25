require 'q/db_service'

module Q
  class ReviewReplyService

    def initialize(model)
      @db_service = Q::DBService.new(model)
    end

    def find(review_id)
      db_service.find_by_id(review_id)
    end

    def reviews_for(user_id)
      db_service.find_all({:reviewer_id => user_id})
    end

    def create_review(user_id, review_request_id)
      db_service.create({:reviewer_id => user_id,
                         :review_request_id => review_request_id})
    end



    private
    attr_reader :db_service

  end
end
