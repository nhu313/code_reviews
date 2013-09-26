require 'q/db_service'

module Q
  class ReviewRequestService

    def initialize(model, user_id)
      @db_service = Q::DBService.new(model)
      @user_id = user_id
    end

    def create(user_id, params)
      attributes = Hash[:title => params[:title],
                        :url => params[:url],
                        :description => params[:description],
                        :user_id => user_id,
                        :posted_date => DateTime.now]

      @request = db_service.create(attributes)
    end

    def user_requests
      db_service.find_all({:user_id => user_id})
    end

    def find(request_id)
      db_service.find_by_id(request_id)
    end

    def next_request_in_queue
      db_service.all.detect { |r| r.user_id != user_id and !r.review_reply}
    end

    private
    attr_reader :db_service, :user_id
  end
end
