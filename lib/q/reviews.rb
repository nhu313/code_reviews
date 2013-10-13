require 'q/db_service'

module Q
  class Reviews

    def self.for(user_id)
      Reviews.new(user_id)
    end

    def submitted
      db.find_all({:user_id => user_id, :archive => false})
    end

    def taken
      db.find_all({:reviewer_id => user_id})
    end

    private
    attr_reader :user_id, :db

    def initialize(user_id)
      @user_id = user_id
      @db = DBService.create(:review_request)
    end
  end
end
