require 'q/services/review_reply'
require 'q/services/review_request'
require 'q/services/user'

module Q
  module Services
    class Factory
      def self.models=(models)
        @models = models
      end

      def self.models
        @models
      end

      def self.db_service=(db)
        @db_service = db
      end

      def self.db_service(model_name)
        @db_service.new(@models[model_name])
      end

      def self.create(service_name, user_id)
        db = db_service(service_name)

        case service_name
        when :review_reply
          return ReviewReply.new(user_id, db)
        when :review_request
          return ReviewRequest.new(user_id, db)
        when :user
          return User.new(db)
        else
          puts "Can't find the service #{service_name}"
        end

      end
    end
  end
end
