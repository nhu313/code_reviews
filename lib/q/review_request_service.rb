require 'q/db_service'

module Q
  class ReviewRequestService

    def initialize(user_id, request_model, skip_history_model)
      @request_db_service = DBService.new(request_model)
      @skip_history_db_service = DBService.new(skip_history_model)
      @user_id = user_id
    end

    def create(user_id, attributes)
      request_attributes = Hash[:title => attributes[:title],
                                :url => attributes[:url],
                                :description => attributes[:description],
                                :user_id => user_id,
                                :posted_date => DateTime.now]

      request_db_service.create(request_attributes)
    end

    def user_requests
      request_db_service.find_all({:user_id => user_id})
    end

    def find(request_id)
      request_db_service.find_by_id(request_id)
    end

    def next_request_in_queue
      request_db_service.all.detect { |r| r.user_id != user_id and !r.review_reply}
    end

    def valid?(attributes)
      return false if attributes.blank?
      return false if attributes[:title].blank?
      return false if attributes[:url].blank?
      return true
    end

    def skip_request(request_id)
      save_skip_request_history(request_id)
    end

    private
    attr_reader :user_id, :request_db_service, :skip_history_db_service

    def save_skip_request_history(request_id)
      skip_history = skip_history_db_service.find_first({:user_id => user_id})
      if skip_history
        skip_history_db_service.update(skip_history.id, {:review_request_id => request_id})
      else
        skip_history_db_service.create({:user_id => user_id, :review_request_id => request_id})
      end
    end

  end
end
