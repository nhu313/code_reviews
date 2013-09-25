class MockReviewRequest
  attr_accessor :user_id, :review_reply

  def initialize(user_id)
    @user_id = user_id
  end
end
