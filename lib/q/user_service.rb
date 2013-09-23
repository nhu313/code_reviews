module Q
  class UserService

    def initialize(db_service)
      @db_service = db_service
    end

    def user_id_for(auth)
      user = db_service.find({:uid => auth["uid"]}) || create_user(auth)
      user.id
    end

    private
    attr_reader :db_service

    def create_user(auth)
      db_service.create(uid: auth["uid"],
                        first_name: auth["info"]["first_name"],
                        last_name: auth["info"]["last_name"],
                        email: auth["info"]["email"])
    end
  end
end
