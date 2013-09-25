require 'q/db_service'

module Q
  class ReviewRequestService

    def initialize(model)
      @db_service = Q::DBService.new(model)
    end

    def create(user_id, params)
      attributes = Hash[:title => params[:title],
                        :url => params[:url],
                        :description => params[:description],
                        :user_id => user_id,
                        :posted_date => DateTime.now]

      @request = db_service.create(attributes)
    end

    def requests_for(user_id)
      db_service.find_all({:user_id => user_id})
    end

    def find(request_id)
      db_service.find({:id => request_id})
    end

    def next_request_in_queue(user_id)
      db_service.all.detect { |request| request.user_id != user_id and !request.review
      }
    end

    private
    attr_reader :db_service
  end
end
