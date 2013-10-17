module Q
  module Services
    class UserService

      def initialize(db)
        @db_service = db
      end

      def user_id_for(auth)
        user = db_service.find_first({:uid => auth["uid"]}) || create_user(auth)
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
end
