module Q
  class MockSkippedReviewRequest
    attr_reader :user_id, :last_skipped_date

    def initialize(user_id, skipped_date)
      @user_id = user_id
      @last_skipped_date = skipped_date
    end
  end
end
