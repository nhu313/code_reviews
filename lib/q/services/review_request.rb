module Q
  module Services
    class ReviewRequest

      def initialize(user_id, db)
        @request_db_service = db
        @user_id = user_id
      end

      def extract_attributes(params)
        Hash[ :title => params[:title],
              :url => params[:url],
              :description => params[:description]]
      end

      def create(params)
        request_attributes = extract_attributes(params)
        request_attributes[:user_id] = user_id
        request_attributes[:posted_date] = DateTime.now

        request_db_service.create(request_attributes)
      end

      def find(request_id)
        request_db_service.find_by_id(request_id)
      end

      def valid?(attributes)
        return false if attributes.blank?
        return false if attributes[:title].blank?
        return false if attributes[:url].blank?
        return true
      end

      def archive(request_id)
        request_db_service.update(request_id, {:archive => true})
      end

      private
      attr_reader :user_id, :request_db_service
    end
  end
end
