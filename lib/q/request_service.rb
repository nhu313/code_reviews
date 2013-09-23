module Q
  class RequestService

    def initialize(db_service)
      @db_service = db_service
    end

    def create(user_id, attributes)
      attributes[:user_id] = user_id
      # attributes[:date_posted] = Date
      @request = db_service.create(attributes)
    end

    def requests_for(user_id)
      db_service.find_all({:user_id => user_id})
    end

    def find(request_id)
      db_service.find({:id => request_id})
    end

    private
    attr_reader :db_service
  end
end
