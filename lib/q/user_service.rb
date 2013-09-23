module Q
  class UserService

    def initialize(db_service)
      @db_service = db_service
    end

    def get_user_id(auth)
      user = User.find_by_uid(auth["uid"]) || create_user(auth)
      user.id
    end

    private
    attr_reader :db_service

    def create_user(auth)
      User.create!(uid: auth["uid"],
                  first_name: auth["info"]["first_name"],
                  last_name: auth["info"]["last_name"],
                  email: auth["info"]["email"])
    end
  end
end
