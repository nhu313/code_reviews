require 'q/db_service'

module Q
  class ReviewRequestService

    def initialize(user_id, request_model, skip_history_model)
      @request_db_service = DBService.new(request_model)
      @skip_history_db_service = DBService.new(skip_history_model)
      @user_id = user_id
    end

    def extract_attributes(params)
      Hash[ :title => params[:title],
            :url => params[:url],
            :description => params[:description]]
    end

    def create(user_id, params)
      request_attributes = extract_attributes(params)
      request_attributes[:user_id] = user_id
      request_attributes[:posted_date] = DateTime.now

      request_db_service.create(request_attributes)
    end

    def user_requests
      request_db_service.find_all({:user_id => user_id})
    end

    def homepage_user_requests
      request_db_service.find_all({:user_id => user_id, :archive => false})
    end

    def find(request_id)
      request_db_service.find_by_id(request_id)
    end

    def next_request_in_queue
      skip_request_id = last_skip_request_id
      request_db_service.all.detect do |r|
        r.user_id != user_id and !r.review_reply and r.id > skip_request_id
      end
    end

    def valid?(attributes)
      return false if attributes.blank?
      return false if attributes[:title].blank?
      return false if attributes[:url].blank?
      return true
    end

    def save_skipped_request(request_id)
      skip_history = skip_history_db_service.find_first({:user_id => user_id})
      if skip_history
        skip_history_db_service.update(skip_history.id, {:review_request_id => request_id})
      else
        skip_history_db_service.create({:user_id => user_id, :review_request_id => request_id})
      end
    end

    def archive(request_id)
      request_db_service.update(request_id, {:archive => true})
    end

    private
    attr_reader :user_id, :request_db_service, :skip_history_db_service

    def last_skip_request_id
      skip_request = skip_history_db_service.find_first({:user_id => user_id})
      return skip_request.review_request_id if skip_request
      return 0
    end

  end
end
