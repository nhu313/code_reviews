require 'q/db_service'

module Q
  class ReviewReplyService

    def initialize(model, user_id)
      @db_service = Q::DBService.new(model)
      @user_id = user_id
    end

    def find(review_id)
      db_service.find_by_id(review_id)
    end

    def user_replies
      db_service.find_all({:reviewer_id => user_id})
    end

    def create_review(review_request_id)
      db_service.create({:reviewer_id => user_id,
                         :review_request_id => review_request_id})
    end



    private
    attr_reader :db_service, :user_id

  end
end
