require 'q/db_service'

module Q
  class ReviewRequestService

    def initialize(model, user_id)
      @db_service = Q::DBService.new(model)
      @user_id = user_id
    end

    def create(user_id, attributes)
      request_attributes = Hash[:title => attributes[:title],
                                :url => attributes[:url],
                                :description => attributes[:description],
                                :user_id => user_id,
                                :posted_date => DateTime.now]

      db_service.create(request_attributes)
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

    def valid?(attributes)
      return false if attributes.blank?
      return false if attributes[:title].blank?
      return false if attributes[:url].blank?
      return true
    end

    private
    attr_reader :db_service, :user_id
  end
end
