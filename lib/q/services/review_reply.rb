module Q
  module Services
    class ReviewReply

      def initialize(user_id, db)
        @db_service = db
        @user_id = user_id
      end

      def find(review_id)
        db_service.find_by_id(review_id)
      end

      def create_reply(review_request_id, attributes)
        db_service.create({:review_request_id => review_request_id,
                           :url => attributes[:url],
                           :comment => attributes[:comment],
                           :posted_date => DateTime.now
                           })
      end

      private
      attr_reader :db_service, :user_id
    end
  end
end
