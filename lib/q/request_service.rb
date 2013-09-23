module Q
  class RequestService
    def create(user_id, attributes)
      attributes[:user_id] = user_id
      attributes[:date_posted] = DateTime.new
      @request = Request.create(attributes)
    end

    def requests_for(user_id)
      Request.find_all_by_user_id(user_id)
    end
  end
end
