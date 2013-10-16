require 'q/services/factory'

module Q
  class Reviews

    def self.for(user_id)
      Reviews.new(user_id)
    end

    def submitted
      db.find_all({:user_id => user_id, :archive => false})
    end

    def taken
      taken_request = db.find_all({:reviewer_id => user_id})
      taken_request.find_all {|r| !r.completed?}
    end

    private
    attr_reader :user_id, :db

    def initialize(user_id)
      @user_id = user_id
      @db = Services::Factory.db_service(:review_request)
    end
  end
end
