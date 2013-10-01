class MockReviewRequest
  attr_accessor :user_id, :id, :review_reply

  def initialize(user_id, id = 1)
    @user_id = user_id
    @id = id
  end

  def completed?
    true
  end
end
