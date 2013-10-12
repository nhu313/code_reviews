module Q
  class MockSkippedReviewRequest
    attr_reader :user_id, :posted_date

    def initialize(user_id, posted_date = DateTime.new)
      @user_id = user_id
      @posted_date = posted_date
    end
  end
end
